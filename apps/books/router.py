from rest_framework.routers import DefaultRouter
from .views import PublishViewSet, BookViewSet, AuthorViewSet

book_router = DefaultRouter()
book_router.register(r'publish', PublishViewSet, base_name='publish')
book_router.register(r'author', AuthorViewSet, base_name='author')
book_router.register(r'book', BookViewSet, base_name='book')
