from django.db import models

# Create your models here.
class Item(models.Model):
    item_name = models.CharField(max_length=100)
    item_desc = models.TextField()
    item_price = models.DecimalField(max_digits=5, decimal_places=2)
    item_img = models.URLField(max_length=500, default='https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fimage-coming-soon&psig=AOvVaw2MFl0qv7Tb_--KmQ17Fh21&ust=1713129611626000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJDz56CPwIUDFQAAAAAdAAAAABAE')
    item_preptime = models.IntegerField(default=0)