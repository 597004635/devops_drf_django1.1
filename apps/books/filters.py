import django_filters
from .models import Book, Author, Publish

class PublishFilter(django_filters.FilterSet):
    name = django_filters.CharFilter(name="name", lookup_expr="contains")
    class Meta:
        model = Publish
        fields = ['name']

class AuthorFilter(django_filters.FilterSet):
    name = django_filters.CharFilter(name="name", lookup_expr="contains")
    class Meta:
        model = Author
        fields = ['name']

class BookFilter(django_filters.FilterSet):
    name = django_filters.CharFilter(name="name", lookup_expr="contains")
    class Meta:
        model = Book
        fields = ['name']
