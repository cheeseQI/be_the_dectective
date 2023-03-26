from django.shortcuts import render

# Create your views here.
from django.http import HttpResponse
import openai

openai.api_key = "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"
openai.organization = "org-16Dqr6ZJhyzkIU8a1x2G4tIE"

conversation = [{"role": "system", "content": "You are the roles of Princess Dragomiroff in story"
                                              "Murder on the Orient Express, "
                                              "you need to answer my questions in her tongue"}]

def index(request):
    conversation.append({"role": "user", "content": input("user: ")})
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=conversation
    )
    conversation.append({"role": "assistant", "content": response['choices'][0]['message']['content']})
    return HttpResponse(response['choices'][0]['message']['content'])
