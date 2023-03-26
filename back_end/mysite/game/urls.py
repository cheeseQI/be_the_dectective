from django.urls import path

from . import views

urlpatterns = [
    path('start', views.start, name='start'),
    path('chat_with_npc', views.chat_with_npc, name='chat_with_npc'),
    path('add_game', views.add_game, name='add_game')
]
