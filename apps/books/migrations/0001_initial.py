# -*- coding: utf-8 -*-
# Generated by Django 1.11.11 on 2020-11-03 18:24
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Author',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(help_text='作者名', max_length=40, verbose_name='作者名')),
                ('email', models.EmailField(help_text='作者邮箱', max_length=254, verbose_name='作者邮箱')),
                ('phone', models.CharField(blank=True, help_text='手机号码', max_length=11, null=True, verbose_name='手机号码')),
                ('address', models.CharField(blank=True, help_text='作者地址', max_length=128, null=True, verbose_name='作者地址')),
            ],
            options={
                'verbose_name': '作者信息',
                'verbose_name_plural': '作者信息',
            },
        ),
        migrations.CreateModel(
            name='Book',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(help_text='书名', max_length=100, verbose_name='书名')),
                ('publication_date', models.DateField(blank=True, help_text='出版日期', null=True, verbose_name='出版时间')),
                ('authors', models.ManyToManyField(help_text='作者', to='books.Author', verbose_name='作者')),
            ],
            options={
                'verbose_name': '图书信息',
                'verbose_name_plural': '图书信息',
                'ordering': ['-publication_date'],
            },
        ),
        migrations.CreateModel(
            name='Publish',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(help_text='出版商名', max_length=30, verbose_name='出版商名称')),
                ('city', models.CharField(blank=True, help_text='出版商城市', max_length=60, null=True, verbose_name='出版商城市')),
                ('address', models.CharField(help_text='出版商地址', max_length=60, verbose_name='出版商地址')),
            ],
            options={
                'verbose_name': '出版商信息',
                'verbose_name_plural': '出版商信息',
            },
        ),
        migrations.AddField(
            model_name='book',
            name='publisher',
            field=models.ForeignKey(help_text='出版商', on_delete=django.db.models.deletion.CASCADE, to='books.Publish', verbose_name='出版社'),
        ),
    ]
