# Templates
- Here we use template to pass our html file in the views as a return.
- So we don't have to pass whole html code in views return.
- With the help of templates we can pass database entries and html file.

### Steps to create template for our food app
1. Goto the item dir and make a dir with the name of templates.
2. Again create a dir inside the template named items.
3. Now, in the items we can create our templates. eg: index.html
4. To render this template into our views.
    
    - import loader: ```from django.template import loader ```
    - Load our template in views:
    ```py
        def index(request):
            template = loader.get_template('items/index.html')
            context = {}
            return render(request, template, context)
    ```

5. Now, we have passed the item_list to our context.
6. so, to print this item_list it follow some syntax
```html
    <!-- index.html -->
    <h1>Item list</h1>
    <ul>
    {% for item in item_list %}
        <li>{{item}}</li>
    {% endfor %}
    </ul>
```
- Template allows us to combine the static and dynamic page.

## Now we will create our detail view for our items.
- Here idea is to show the detail view of our item whatever item we select.
- To achieve this we will follow some steps:

    1. Create view for the details
    ```py
    def details(request, id):
        item = Item.objects.get(pk=id)
        return render(request, 'items/details.html', {'item':item})
    ```
    2. Create url path
    ```py
        path('details/<int:id>/', views.deatails, name='details'),
    ```
    3. Create template details.html
    ```html
        <h1>{{item.item_name}}</h1>
        <h1>{{item.item_price}}</h2>
        .....
    ```
    4. Check if everything is workin fine or not.


## Removing hardcoded url
```html
<a href="{% url 'name_of_the_path/url' item_id %}></a>
```