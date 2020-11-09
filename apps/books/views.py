from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.status import HTTP_200_OK, HTTP_400_BAD_REQUEST
from rest_framework.pagination import PageNumberPagination
from rest_framework import filters
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.authentication import TokenAuthentication, BasicAuthentication, SessionAuthentication
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.permissions import IsAuthenticated

from .models import Publish, Author, Book
from .serializers import PublishSerializer, BookSerializer, AuthorSerializer
from .filters import PublishFilter, AuthorFilter, BookFilter

class Pagination(PageNumberPagination):
    page_size = 10
    page_size_query_param = 'page_size'
    page_query_param = 'page'
    max_page_size = 100

class PublishViewSet(viewsets.ModelViewSet):
    # 出版商信息
    authentication_classes = (JSONWebTokenAuthentication, TokenAuthentication, SessionAuthentication, BasicAuthentication)

    queryset = Publish.objects.all()
    serializer_class = PublishSerializer
    pagination_class = Pagination
    filter_backends = (DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter)
    filter_class = PublishFilter
    search_fields = ('name', 'city')
    ordering_fields = ('city',)


class BookViewSet(viewsets.ModelViewSet):
    # 图书信息
    authentication_classes = (JSONWebTokenAuthentication, TokenAuthentication, SessionAuthentication, BasicAuthentication)
    rmission_classespe = (IsAuthenticated,)

    queryset = Book.objects.all()
    serializer_class = BookSerializer
    pagination_class = Pagination
    filter_backends = (DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter)
    filter_class = BookFilter
    search_fields = ('name',)
    ordering_fields = ('publication_date',)

class AuthorViewSet(viewsets.ModelViewSet):
    # 作者信息
    authentication_classes = (JSONWebTokenAuthentication, TokenAuthentication, SessionAuthentication, BasicAuthentication)
    rmission_classespe = (IsAuthenticated,)

    queryset = Author.objects.all()
    serializer_class = AuthorSerializer
    pagination_class = Pagination
    filter_backends = (DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter)
    filter_class = AuthorFilter
    search_fields = ('name', 'email')
    ordering_fields = ('name',)
