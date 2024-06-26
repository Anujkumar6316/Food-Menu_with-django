from django.shortcuts import render, redirect
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.decorators import login_required

# from django.contrib.auth
# Create your views here.
def login(request):
    return render(request, 'users/login.html')

def register(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if(form.is_valid()):
            form.save()
            return redirect('users:login')
        
    else:
        form = UserCreationForm()
    return render(request, 'users/register.html', {'form': form})

@login_required
def profileView(request):
    return render(request, 'users/profile.html')