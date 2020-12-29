class Article < ApplicationRecord
  belongs_to :user
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  def self.search(search)
    if search != ""
      Article.where('(title LIKE(?)) OR (text LIKE(?))', "%#{search}%", "%#{search}%")
    end
  end

end



