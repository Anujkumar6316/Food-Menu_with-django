from .models import Item
from django import forms

class ItemForm(forms.ModelForm):
    class Meta:
        model = Item
        fields = ['item_name', 'item_img', 'item_price', 'item_desc', 'item_preptime']