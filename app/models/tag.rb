class Tag < ApplicationRecord
  has_many :articles, through: :article_tags
  has_many :article_tags

  validates :subj, presence: true
end
