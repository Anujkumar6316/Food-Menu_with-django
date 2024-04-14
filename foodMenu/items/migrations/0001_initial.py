# Generated by Django 5.0.4 on 2024-04-13 14:17

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Item',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('item_name', models.CharField(max_length=100)),
                ('item_desc', models.TextField()),
                ('item_price', models.DecimalField(decimal_places=2, max_digits=5)),
                ('item_img', models.ImageField(default='items/static/images/default.jpg', upload_to='items/static/images')),
            ],
        ),
    ]
