"""
Django settings for devops project.

Generated by 'django-admin startproject' using Django 1.11.11.

For more information on this file, see
https://docs.djangoproject.com/en/1.11/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.11/ref/settings/
"""

import os
import sys
import datetime

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(BASE_DIR, "apps"))


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.11/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '2pv3ky6ap#m$5z_ak5sj#@r#y11#jz42j1$7!t%(3=lnw655sz'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True
# DEBUG = False

ALLOWED_HOSTS = ['*']


# Application definition

INSTALLED_APPS = [
    # 'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    # 添加额外app
    'corsheaders',
    'rest_framework',
    'django_filters',
    # 删除不续约的authtoken（没有前后端分离时可使用的认证）
    # 'rest_framework.authtoken',

    # 添加自定义app
    'menu.apps.MenuConfig',
    'accounts.apps.AccountsConfig',
    'resources.apps.ResourcesConfig',
    'zabbix.apps.ZabbixConfig',
    'books.apps.BooksConfig',
]

MIDDLEWARE = [
    # 'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'corsheaders.middleware.CorsMiddleware',  # #添加中间件
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'devops.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'devops.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.11/ref/settings/#databases

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.sqlite3',
#         'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
#     }
# }

DATABASES = {
      'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'devops',
        'HOST': '127.0.0.1',
        'USER': 'root',
        'PASSWORD': 'xxxxxx',
        'PORT': "3306",
        'OPTIONS': {
           'init_command': "SET storage_engine=INNODB;SET sql_mode='STRICT_TRANS_TABLES'",
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'",
            'charset': 'utf8mb4',
            'use_unicode': True,
        }
    },
    # "zabbix": {
    #     'ENGINE': 'django.db.backends.mysql',
    #     'NAME': "zabbix_server",
    #     'USER': 'zabbix',
    #     'PASSWORD': "xxxxxx",
    #     'HOST': "bj-xxxxxxx",
    #     'PORT': "61253",
    #     # 'OPTIONS': {
    #     #     'init_command': "SET storage_engine=INNODB;SET sql_mode='STRICT_TRANS_TABLES'"
    #     # }
    # }
}


# Password validation
# https://docs.djangoproject.com/en/1.11/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/1.11/topics/i18n/

# LANGUAGE_CODE = 'en-us'
LANGUAGE_CODE = 'zh-hans'

# TIME_ZONE = 'UTC'
TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

# USE_TZ = True
USE_TZ = False


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.11/howto/static-files/

STATIC_URL = '/static/'


### 自定义变量 START ###
AUTH_USER_MODEL = "accounts.User"
ADMIN_LOGIN = "admin"
DOMAIN = "@xxxx.com"

REST_FRAMEWORK = {
    'DEFAULT_FILTER_BACKENDS': ("django_filters.rest_framework.DjangoFilterBackend",),
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework_jwt.authentication.JSONWebTokenAuthentication',
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.BasicAuthentication',
        # 'rest_framework.authentication.TokenAuthentication',
    ),
    'DEFAULT_PERMISSION_CLASSES': (
        'devops.permissions.ModelPermissions',
    ),
    'DEFAULT_PAGINATION_CLASS': 'devops.paginations.Pagination',
    'PAGE_SIZE': 10
}

JWT_AUTH = {
    'JWT_EXPIRATION_DELTA': datetime.timedelta(minutes=360),
    'JWT_AUTH_HEADER_PREFIX': 'JWT',
}

# 跨域设置
# 允许跨域时携带cookie
# CORS_ALLOW_CREDENTIALS = True
CORS_ORIGIN_ALLOW_ALL = DEBUG

# 所有域名（ip）都可访问后端接口，默认False
CORS_ORIGIIN_ALLOW_ALL = True
# 跨域请求白名单
# CORS_ORIGIN_WHITELIST = (
#     'http://127.0.0.1:8000',
#     'http://192.168.1.50:8000',
#     'http://localhost:9528',
#     'http://192.168.1.50:9528',
# )
# 默认请求方法
CORS_ALLOW_METHODS = (
    'DELETE',
    'GET',
    'OPTIONS',
    'PATCH',
    'POST',
    'PUT',
    'VIEW',
)
# 默认请求头
CORS_ALLOW_HEADERS = (
    'accept',
    'accept-encoding',
    'authorization',
    'content-type',
    'dnt',
    'origin',
    'user-agent',
    'x-csrftoken',
    'x-requested-with',
    # 添加自定义的请求头，如果不添加会报错 OPTIONS 403
    'Token',
    # 'authtoken',
    # 'Authorization'
)

# 需要过滤掉的网卡设备名
FILTER_NETWORK_DEVICE = ["docker", "veth", "tun", "sit", "br"]


# zabbix
ZABBIX_API = "https://xxxx.com/"
ZABBIX_ADMIN_USER = "zabbix"
ZABBIX_ADMIN_PASS = "xxxxxxx"
ZABBIX_DEFAULT_HOSTGROUP = "32"


# LOGGING = {
#     'version': 1,
#     'disable_existing_loggers': False,
#     'formatters': {
#         'verbose': {'format': '%(asctime)s %(levelname)s %(message)s'},
#         'simple': {'format': '%(levelname)s %(message)s'},
#         'default': {
#             'format': '%(asctime)s [%(name)s:%(lineno)d] [%(levelname)s] - %(message)s',
#             'datefmt': '%Y-%m-%d %H:%M:%S'
#         }
#     },
#     'handlers': {
#         'null': {
#             'level':'DEBUG',
#             'class':'logging.NullHandler',
#         },
#         'sentry': {
#             'level': 'ERROR',
#             'class': 'raven.contrib.django.raven_compat.handlers.SentryHandler',
#             'tags': {'custom-tag': 'x'},
#         },
#         'console':{
#             'level':'DEBUG',
#             'class':'logging.StreamHandler',
#             'formatter': 'default'
#         },
#         'django':{
#             'level': 'DEBUG',
#             'class': 'logging.FileHandler',
#             'filename': os.path.join(BASE_DIR, 'logs', 'django.log'),
#             'formatter': 'default'
#
#         },
#         'root_handler': {
#             'level': 'DEBUG',
#             'class': 'logging.handlers.TimedRotatingFileHandler',
#             'formatter': 'default',
#             'filename': os.path.join(BASE_DIR, 'logs', 'server.log'),
#             'when': 'D',
#             'interval': 1,
#             'encoding': 'utf8',
#         },
#         'django_request_handler':{
#             'level': 'DEBUG',
#             'class': 'logging.handlers.TimedRotatingFileHandler',
#             'formatter': 'default',
#             'filename': os.path.join(BASE_DIR, 'logs', 'request.log'),
#             'when': 'D',
#             'interval': 7,
#             'encoding': 'utf8',
#         },
#         'django_db_backends_handler':{
#             'level': 'DEBUG',
#             'class': 'logging.handlers.TimedRotatingFileHandler',
#             'formatter': 'verbose',
#             'filename': os.path.join(BASE_DIR, 'logs', 'db_backends.log'),
#             'when': 'D',
#             'interval': 7,
#         }
#     },
#     'loggers' : {
#         'django': {
#             'level': 'DEBUG',
#             'handlers': ['django'],
#             'propagate': False
#         },
#         'django.request': {
#             'handlers': ['django_request_handler'],
#             'level': 'DEBUG',
#             'propagate': False,
#         },
#         'django.db.backends':{
#             'handlers': ['django_db_backends_handler'],
#             'level': 'DEBUG',
#             'propagate': False,
#         }
#     },
#     'root':{
#         'level': 'DEBUG',
#         'handlers': ['root_handler']
#     }
# }


### 自定义变量 END ###
