from foodMenu.urls import urlpatterns
from django.test import TestCase

class urlsTestcase(TestCase):
    def test_include(self):
        response = self.client.get('')
        self.assertTrue(response.status_code, 200)

    def test_admin_not_loged_in(self):
        response = self.client.get('admin/')
        self.assertTrue(response.status_code, 302)

    def test_admin_logged_in(self):
        self.client.login(username='anuj', password='Anuj@123')
        response = self.client.get('admin/')
        self.assertTrue(response.status_code, 200)
