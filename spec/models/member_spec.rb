# -*- coding: utf-8 -*-
require 'spec_helper'

describe Member do
  before do
    @diary1 = Diary.create(title: 'diary1')
    @diary2 = Diary.create(title: 'diary2')

    @tanaka = User.create(name: 'tanaka')
    @yamada = User.create(name: 'yamada')
    @suzuki = User.create(name: 'suzuki')

    @diary1.users << @tanaka
    @diary1.users << @yamada
    @diary2.users << @suzuki

    @member1 = Member.find_by_user_id_and_diary_id(@tanaka.id, @diary1.id)
    @member2 = Member.find_by_user_id_and_diary_id(@yamada.id, @diary1.id)
    @member3 = Member.find_by_user_id_and_diary_id(@suzuki.id, @diary2.id)

    @member1.sort = 1
    @member1.baton = @tanaka.id
    @member1.save

    @member2.sort = 2
    @member2.baton = @tanaka.id
    @member2.save

    @member3.sort = 1
    @member3.baton = @suzuki.id
    @member3.save

  end
  context "#baton_pass" do
    it "baton が次のユーザーIDに更新される" do
      @member1.baton_pass
      Member.find(@member1.id).baton.should == @yamada.id
    end
  end
end
