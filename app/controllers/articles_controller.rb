class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new, :destroy, :create]

  def index
    # @articles = Article.all.order('created_at DESC').includes(:user)
    @articles = Article.all.order('created_at DESC').includes(:user).page(params[:page]).per(10)
  end

  def new
    @article = ArticleTagTable.new
  end

  def create
    @article = ArticleTagTable.new(article_params)
    if @article.valid?
       @article.save
       return redirect_to root_path
    else
       render "new"
    end
  end

  def show
    @article = Article.find(params[:id])
    gon.article = @article
    @message = Message.new
    @messages = @article.messages.order('created_at DESC').includes(:user)
    if user_signed_in?
      gon.user = current_user.nickname
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy if current_user == @article.user

    redirect_to root_path
  end

  def search
    if params[:keyword].present?
      @articles = Article.search(params[:keyword]).order('created_at DESC').includes(:user)
    else
      redirect_to root_path
    end
  end



  private

  def article_params
    params.require(:article_tag_table).permit(:text, :title, :subj).merge(user_id: current_user.id)
  end


end
