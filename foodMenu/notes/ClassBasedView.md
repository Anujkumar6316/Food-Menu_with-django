# Class based views
- Implementing the class based view to our index view.
```py 
# index view
def index(request):
    template = 'items/index.html'
    item_list = Item.objects.all()
    context = {'item_list': item_list}
    return render(request, template, context)
```
```py
# classbasedview of index view
class indexClassBasedView(ListView):
    model = Item
    template_name = 'items/index.html'
    context_object_name = 'item_list'
```