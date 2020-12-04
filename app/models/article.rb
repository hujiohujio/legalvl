class Article < ApplicationRecord
  belongs_to :user
  has_many :tags, through: :article_tag
  has_many :article_tag

  validates :text, presence: true
  validates :title, presence: true
end



