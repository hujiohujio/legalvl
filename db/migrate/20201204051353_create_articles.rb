class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, foreign_key: true
      t.text :text,       null: false
      t.text :title,      null: false
      t.timestamps
    end
  end
end
