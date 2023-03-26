import json
import pymongo

from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse
from django.http import JsonResponse
import openai
import uuid

from django.views.decorators.csrf import csrf_exempt

from . import passwd

# todo: need a separate api interface
openai.api_key = passwd.key
openai.organization = passwd.org

conversation = [{"role": "system", "content": "You are the roles of Princess Dragomiroff in story"
                                              "Murder on the Orient Express, "
                                              "you need to answer my questions in her tongue"}]


def start(request):
    # get script from scriptList; and also the uuid
    uuid_str = str(uuid.uuid4())
    json_data = "{}"
    data = json.loads(json_data)
    data["uuid"] = uuid_str
    json_data = json.dumps(data)

    return HttpResponse(json_data, content_type='application/json')


@csrf_exempt
def chat_with_npc(request):
    if request.method == 'POST':
        # Handle the POST request data
        msg = request.POST.get('message')
        conversation.append({"role": "user", "content": msg}) # todo: store in database!
        reply = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=conversation
        )
        conversation.append({"role": "assistant", "content": reply['choices'][0]['message']['content']})

        json_data = "{}"
        data = json.loads(json_data)
        data["content"] = reply['choices'][0]['message']['content']
        return JsonResponse(data, status=200)
    else:
        # Handle other HTTP methods
        response_data = {'message': 'This endpoint only accepts POST requests.'}
        return JsonResponse(response_data, status=405)



def add_game(request):
    conversation.append({"role": "user", "content": input("user: ")})
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=conversation
    )
    conversation.append({"role": "assistant", "content": response['choices'][0]['message']['content']})
    return HttpResponse(response['choices'][0]['message']['content'])


def test(request):
    json_data = "{}"
    data = json.loads(json_data)
    data["name"] = "something, cool cool fangze"
    response = JsonResponse(data, status=200)
    return response
