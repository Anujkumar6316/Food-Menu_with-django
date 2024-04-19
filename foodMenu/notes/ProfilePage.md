# Creating profile page
## Task
- Creating profile for each user who is registered on our website.
- Profile will have the one-on-one relationship means for every user we will have a profile page.
- Do deletion of any user we will also delete the profile page.
- Our profile page will be containg img, user, and location details.(models)


## 1. Creating profile page
- Create view for our profile.
- Add url for our profile.
- Create the template and see if its printing the username or not.

## 2. Creating profile model
- Creating profile model
```py
from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    img = models.ImageField(default='default.jpg', upload_to='profile_pic')
    location = models.CharField(max_length=100)

    def __str__(self):
        return self.user.username
```

- Adding profile model to our admin panel
```py
from django.contrib import admin
from .models import Profile

# Register your models here.
admin.site.register(Profile)
```

- At last make migrations to show the results
```bash

python manage.py makemigrations
python manage.py migrate

```
## 3. Adding path to upload image
```py
MEDIA_ROOT = os.path.join(BASE_DIR, 'pictures')
MEDIA_URL = '/pictures/'
```
- This code will generate pictures dir in our base location and store the image into this.

## 4. Adding user profile pricture
