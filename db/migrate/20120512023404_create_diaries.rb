class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.string :title
      t.boolean :deliver

      t.timestamps
    end
  end
end
