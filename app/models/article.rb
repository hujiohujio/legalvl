class Article < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :article_tags, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :messages, dependent: :destroy
  

end



