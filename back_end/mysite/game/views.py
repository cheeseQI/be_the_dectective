import json

from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse
import openai
import uuid

from . import passwd

# todo: need a separate api interface
openai.api_key = passwd.key
openai.organization = passwd.org

conversation = [{"role": "system", "content": "You are the roles of Princess Dragomiroff in story"
                                              "Murder on the Orient Express, "
                                              "you need to answer my questions in her tongue"}]

def start(request):
    # get script from scriptList; and also the uuid
    json_data = '[{"name": "Alice", "age": 30}, {"name": "Bob", "age": 25}]'
    data = json.loads(json_data)
    uuid_str = str(uuid.uuid4())
    data.append("uuid", uuid_str)
    json_data = json.dumps(data)

    return HttpResponse(json_data, content_type='application/json')


def chat_with_npc(request):
    conversation.append({"role": "user", "content": input("user: ")})
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=conversation
    )
    conversation.append({"role": "assistant", "content": response['choices'][0]['message']['content']})
    return HttpResponse(response['choices'][0]['message']['content'])


def add_game(request):
    conversation.append({"role": "user", "content": input("user: ")})
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=conversation
    )
    conversation.append({"role": "assistant", "content": response['choices'][0]['message']['content']})
    return HttpResponse(response['choices'][0]['message']['content'])