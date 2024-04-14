## 1. Project setup
- create main project foodMenu
- create sub app name items

## 2. Database and models
Q. What are models?
- Large website needs large amount of account to be stored.
- Data for website is store in the database.
- Data in warehouse is stored in form of tables.
- Models allow us to create db tables.
- Models are the blueprint which can be used to create database table
- Models are nothing but classes in python.
- Models are created in the 'manage.py' file.

### Adding model to our items app.
- Django comes with the some of pre-installed apps, for our sqlite database.
- Sqlite is provided by default from django.
- To use these pre-installed apps added from django we need to migrate them to the manage.py by using``` python3 manage.py migrate ```

- Idea:
    
    - Item model will store 4 things:

        - item_name
        - item_img
        - item_price
        - item_desc

```py 
# items/models.py
from django.db import models

# Create your models here.
class Item(models.Model):
    item_name = models.CharField(max_length=100)
    item_desc = models.TextField()
    item_price = models.DecimalField(max_digits=5, decimal_places=2)
    item_img = models.ImageField(upload_to='items/static/images', default='items/static/images/default.jpg')
```
- Now to use this models.py we need to migrate it into our project.
- We have to mirgrate it to our project using ```python3 manage.py makemigrations items```
- After this we need to add table/db by: ```python3 manage.py sqlmigrate food 001```
- Now finally we need to migrate everything```python3 manage.py migrate```.
- To add this model to our admin page we will add below code into our admin.py file in items```admin.site.register(Item)```

### Storing data in the database
1. Open manage.py shell. ```python3 manage.py shell```
2. Import Item from items
3. List all the objects in Item ```Item.objects.all()```
4. Creating object for our Item ``` a = Item(item_name='xyz', item_desc='description', item_price=20.99)```
5. Now save this object. ```a.save()```.
6. Whenever we use point no 3 it will print the id of the objects, So if we want to print the name of the object to do that we will add below code in our models.py in the Item class.
``` py
def __str__(self):
    return self.item_name
```
Above steps were very teadies and time consuming, we can achieve same thing by using the admin panel.
To do we will need create a superuser/admin.``` python3 manage.py createsuperuser ```

- setup the username and password.
- Now go to the localhost:8000/admin
