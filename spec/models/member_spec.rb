# -*- coding: utf-8 -*-
require 'spec_helper'

describe Member do
  before do
    @tanaka = FactoryGirl.create(:user, name: 'tanaka')
    @yamada = FactoryGirl.create(:user, name: 'yamada')
    @suzuki = FactoryGirl.create(:user, name: 'suzuki')

    @diary1 = @tanaka.diaries.create(title: 'diary1')
    @diary2 = @suzuki.diaries.create(title: 'diary2')

    @diary1.baton = @tanaka.id
    @diary1.users << @yamada
    @diary1.save!

    @diary2.baton = @suzuki.id
    @diary2.save!

    @member1 = Member.find_by_user_id_and_diary_id(@tanaka.id, @diary1.id)
    @member2 = Member.find_by_user_id_and_diary_id(@yamada.id, @diary1.id)
    @member3 = Member.find_by_user_id_and_diary_id(@suzuki.id, @diary2.id)

    @member1.sort = 1
    @member1.save!

    @member2.sort = 2
    @member2.save!

    @member3.sort = 1
    @member3.save!

  end
  context "#baton_pass" do
    it "baton が次のユーザーIDに更新される" do
      @diary1.baton.should == @tanaka.id
      @diary1.baton_pass!
      @diary1.baton.should == @yamada.id
    end
  end
end
