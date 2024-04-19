from django.shortcuts import render, redirect
from django.http import HttpResponse
from .models import Item
from .forms import ItemForm

# Class Based Views
from django.views.generic import ListView

# Create your views here.
def index(request):
    template = 'items/index.html'
    item_list = Item.objects.all()
    context = {'item_list': item_list}
    return render(request, template, context)

class indexClassBasedView(ListView):
    model = Item
    template_name = 'items/index.html'
    context_object_name = 'item_list'

def addItem(request):
    if request.method == 'POST':
        form = ItemForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('items:index')
    else:
        form = ItemForm()
    return render(request, 'items/addItem.html', {"form":form})

def update(request, id):
    item = Item.objects.get(pk=id)
    form = ItemForm(request.POST or None, instance=item)

    if form.is_valid():
        form.save()
        return redirect('items:index')
    return render(request, 'items/updateItem.html', {'form':form,'item':item})