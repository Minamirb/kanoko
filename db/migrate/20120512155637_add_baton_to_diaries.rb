class AddBatonToDiaries < ActiveRecord::Migration
  def change
    add_column :diaries, :baton, :integer
  end
end
