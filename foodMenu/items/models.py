from django.db import models

# Create your models here.
class Item(models.Model):
    item_name = models.CharField(max_length=100)
    item_desc = models.TextField()
    item_price = models.DecimalField(max_digits=5, decimal_places=2)
    item_img = models.URLField(max_length=500, default='https://media.istockphoto.com/id/1075374570/vector/coming-soon.jpg?s=612x612&w=0&k=20&c=6W1rSRAoJnxtMSi98mGD7LjiXA3xQMotLn8hJnmXjzI=')
    item_preptime = models.IntegerField(default=0)