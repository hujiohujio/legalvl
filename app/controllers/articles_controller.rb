class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order('created_at DESC').includes(:user)
  end

  def new
    @article = ArticleTag.new
  end

  def create
    @article = ArticleTag.new(article_params)
    if @article.valid?
       @article.save
      #  保存先の科目のページに行くようにしたい
       return redirect_to root_path
    else
       render "new"
    end
  end

  private

  def article_params
    params.require(:article_tag).permit(:text, :title, :subj).merge(user_id: current_user.id)
  end


end
