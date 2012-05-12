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

a1 = Article.create(content: '日記の内容' * 10)
a1.member = m1
a1.save

a2 = Article.create(content: '別の内容' * 10)
a2.member = m1
a2.save

a3 = Article.create(content: '別の日記' * 10)
a3.member = m2
a3.save




