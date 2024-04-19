from django.urls import path
from . import views

app_name = 'items'
urlpatterns = [
    path('',views.indexClassBasedView.as_view(),name='index'),
    path('add/', views.addItem, name='addItem'),
    path('update/<int:id>/', views.update, name='update'),
]