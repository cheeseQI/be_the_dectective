import json
import pymongo

from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse
from django.http import JsonResponse
from . import passwd
from . import util
import openai
import uuid
from bson.objectid import ObjectId

from django.views.decorators.csrf import csrf_exempt

# todo: need a separate api interface
openai.api_key = passwd.key
openai.organization = passwd.org

myclient = pymongo.MongoClient("mongodb+srv://yuqirao9903:admin@cluster0.ylscfqf.mongodb.net/"
                               "?retryWrites=true&w=majority")


# conversation = [{"role": "system", "content": "You are the role of Princess Dragomiroff in story"
#                                               "Murder on the Orient Express, "
#                                               "you need to answer my questions in her tongue"}]


@csrf_exempt
def start(request):
    mydb = myclient["script_list"]
    background_col = mydb["name_background_NPC"]
    mydb1 = myclient["game_info"]
    npc_col = mydb1["NPCs"]
    mydoc = {"NPCs": []}
    obj = npc_col.insert_one(mydoc)
    list = []
    for x in background_col.find({}, {"_id": 0}):
        list.append(x)
    # get script from scriptList; and also the uuid
    uuid_str = str(obj.inserted_id)
    scenes = util.base64_data.decode("utf-8")
    data = {"uuid": uuid_str, "script_list": list, "scenes": scenes}
    json_data = json.dumps(data)
    return HttpResponse(json_data, content_type='application/json')


@csrf_exempt
def chat_with_npc(request):
    if request.method == 'POST':
        input_data = json.loads(request.body)
        uuid = ObjectId(input_data.get('uuid'))
        name = input_data.get('npcName')
        msg = input_data.get('userInput')
        # print(msg)
        mydb1 = myclient["game_info"]
        npc_col = mydb1["NPCs"]
        myquery = {"_id": uuid, 'NPCs.name': name}
        npc_obj = npc_col.find(myquery, {"_id": 0, "NPCs": {"$elemMatch": {"name": name}}})[0]
        # print(npc_obj)
        conversation = npc_obj.get("NPCs")[0].get("conv")
        # print(conversation)
        data = chat_gpt(conversation, msg)
        # npc_obj["conv"] = conversation
        update_operation = {"$set": {"NPCs.$.conv": conversation}}
        npc_col.update_one(myquery, update_operation)
        return JsonResponse(data, status=200)
    else:
        # Handle other HTTP methods
        response_data = {'message': 'This endpoint only accepts POST requests.'}
        return JsonResponse(response_data, status=405)


@csrf_exempt
def check_target(request):
    if request.method == 'POST':
        input_data = json.loads(request.body)
        uuid = ObjectId(input_data.get('uuid'))
        msg = input_data.get('answer')
        mydb1 = myclient["game_info"]
        npc_col = mydb1["NPCs"]
        target_conv = npc_col.find({"_id": uuid}, {"_id": 0, "target_conv": 1})[0].get("target_conv")
        data = chat_gpt(target_conv, msg)
        update_operation = {"$set": {"target_conv": target_conv}}
        npc_col.update_one({"_id": uuid}, update_operation)
        return JsonResponse(data, status=200)
    else:
        # Handle other HTTP methods
        response_data = {'message': 'This endpoint only accepts POST requests.'}
        return JsonResponse(response_data, status=405)


def chat_gpt(conv, msg):
    conv.append({"role": "user", "content": msg})

    reply = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=conv
    )

    conv.append({"role": "assistant", "content": reply['choices'][0]['message']['content']})
    json_data = "{}"
    data = json.loads(json_data)
    data["content"] = reply['choices'][0]['message']['content']
    return data


@csrf_exempt
def add_game(request):
    if request.method == 'POST':
        input_data = json.loads(request.body)
        uuid = input_data.get('uuid')
        script_name = input_data.get('scriptName')
        mydb = myclient["script_list"]
        background_col = mydb["name_background_NPC"]
        myquery = {"name": script_name}
        npc_info_list = background_col.find(myquery, {"_id": 0, "NPCInfos": 1})[0].get("NPCInfos")
        script_target = background_col.find(myquery, {"_id": 0, "target": 1})[0].get("target")
        target_conv = []
        sys_target = "You are a guide to judge whether the user's input is right for " + script_target + "in the " \
                                                                                                         "story of " \
                     + script_name + ". Give the right answer if the user input 'answer'."
        target_conv.append({"role": "system", "content": sys_target})
        npc_list = []
        for npc_info in npc_info_list:
            # data = json.loads(npc_info)
            npc_conv = get_sys_conv(npc_info.get("name"), script_name)
            npc_obj = {"name": npc_info.get("name"), "conv": [{"role": "system", "content": npc_conv}]}
            npc_list.append(npc_obj)

        # print(npc_list)
        mydb1 = myclient["game_info"]
        npc_col = mydb1["NPCs"]
        update_operation = {"$set": {"NPCs": npc_list, "target_conv": target_conv}}
        # print(npc_col.find({"_id": ObjectId(uuid)})[0])
        npc_col.update_one({"_id": ObjectId(uuid)}, update_operation)
        return JsonResponse({}, status=200)

    else:
        # Handle other HTTP methods
        response_data = {'message': 'This endpoint only accepts POST requests.'}
        return JsonResponse(response_data, status=405)


def get_sys_conv(character, story):
    return "You are the role of " + character + " in story " + story + ", you need to answer my questions in his/her " \
                                                                       "tongue "


@csrf_exempt
def test(request):
    json_data = json.loads(request.body)
    print("Request POST:", json_data.get("username"))
    json_data = "{}"
    data = json.loads(json_data)
    data["name"] = "something, cool cool fangze"
    response = JsonResponse(data, status=200)
    return response
