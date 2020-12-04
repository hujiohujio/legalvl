class Tag < ApplicationRecord
  has_many :article, through: :article_tag
  has_many :article_tag

  validates :subj, presence: true
end
