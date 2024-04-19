from django.db.models.signals import post_save
from django.contrib.auth.models import User
from django.dispatch import receiver
from .models import Profile

# here we are using post_save signal to create a profile for every user that is created
# we are using receiver decorator to connect the signal to the function

# this method will create a profile for every user that is created
# sender: the model that sends the signal
# instance: the instance of the model that sends the signal (User in this case)
# created: a boolean that tells us if the instance was created or updated
# kwargs: a dictionary of keyword arguments
# @receiver decorator is used to connect the signal to the function by checking the user is created or not

@receiver(post_save, sender=User)
def build_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

# this method will save the profile for every user that is created
@receiver(post_save, sender=User)   
def save_profile(sender, instance, **kwargs):
    instance.profile.save()