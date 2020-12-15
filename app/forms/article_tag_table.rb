class ArticleTagTable

  include ActiveModel::Model
  attr_accessor :user_id, :text, :title, :subj

  with_options presence: true do
    validates :subj, presence: true
    validates :text, presence: true
    validates :title, presence: true  
  end

  def save
    article = Article.create(user_id: user_id, text: text, title: title)
    tag = Tag.create(subj: subj)
    ArticleTag.create(article_id: article.id, tag_id: tag.id)

  end

end