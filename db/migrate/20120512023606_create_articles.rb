class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :content
      t.references :member

      t.timestamps
    end
    add_index :articles, :member_id
  end
end
