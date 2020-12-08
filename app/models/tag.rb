class Tag < ApplicationRecord
  has_many :articles, through: :article_tags, dependent: :destroy
  has_many :article_tags, dependent: :destroy

  validates :subj, presence: true
end
