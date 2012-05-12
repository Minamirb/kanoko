# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

d1 = Diary.create(title: 'だいありー１')
d2 = Diary.create(title: 'ダイアリー２')

tanaka = User.create(name: '田中')
yamada = User.create(name: '山田')
kato   = User.create(name: '加藤')
suzuki = User.create(name: '鈴木')

d1.users << tanaka
d1.users << yamada
d2.users << kato
d2.users << yamada
d2.users << suzuki

m11 = Member.find_by_user_id_and_diary_id(tanaka.id, d1.id)
m11.sort = 1
m11.baton = tanaka.id
m11.save

m12 = Member.find_by_user_id_and_diary_id(yamada.id, d1.id)
m12.sort = 2
m12.baton = tanaka.id
m12.save

m21 = Member.find_by_user_id_and_diary_id(kato.id, d2.id)
m21.sort = 1
m21.baton = suzuki.id
m21.save

m22 = Member.find_by_user_id_and_diary_id(yamada.id, d2.id)
m22.sort = 2
m22.baton = suzuki.id
m22.save

m23 = Member.find_by_user_id_and_diary_id(suzuki.id, d2.id)
m23.sort = 3
m23.baton = suzuki.id
m23.save

a1 = Article.create(content: '日記の内容' * 10)
m11.articles << a1


a2 = Article.create(content: '別の内容' * 10)
m11.articles << a2

a3 = Article.create(content: '別の日記' * 10)
m22.articles << a3

a4 = Article.create(content: 'ある日記' * 10)
m12.articles << a4

