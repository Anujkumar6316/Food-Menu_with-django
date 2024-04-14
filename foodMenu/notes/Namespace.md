# Namespace
- As in our foodMenu project we have a sub app called items.
- In real world their can be any number of apps where they can have same path name like details, edit, etc.
- So, to overcome the confussion of the path name we use namespace.
- To acheive this we fellow some setups.

    1. In urls.py add ```app_name = 'items'```
    2. Now in our template in href we will add ```app_name:path_name```
    <br>eg: ```href="{% url 'items:index' %}"``` 