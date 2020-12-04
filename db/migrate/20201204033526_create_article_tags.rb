class CreateArticleTags < ActiveRecord::Migration[6.0]
  def change
    create_table :article_tags do |t|

      t.timestamps
    end
  end
end
