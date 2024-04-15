# CRUD: (create, read, update and delete)
## Create
- Here we will create the form for our models to take input form the user.
- To create forms will write below code in the forms.py
```py
from .models import Item
from django import forms

class ItemForm(forms.ModelForm):
    class Meta:
        model = Item
        fields = ['item_name', 'item_img', 'item_price', 'item_desc', 'item_preptime']
```

- Now we have created the forms, next we will work on the views and url path.
```py
# views.py
def addItem(request):
    if request.method == 'POST':
        form = ItemForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('items:index')
    else:
        form = ItemForm()
    return render(request, 'items/addItem.html', {"form":form})
```
```py
# urls.py
path('add/', views.addItem, name='addItem'),
```


## Update/Edit
- This is same as the creating a form, but here we will pass the predefined object's value
- This will also follow the same steps:

    1. Create the views
    ```py

    ```
    2. Create the url path
    3. Next, create the update template

## 
