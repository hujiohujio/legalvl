class Article < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :article_tags
  has_many :article_tags

end



