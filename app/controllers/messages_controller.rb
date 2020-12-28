class MessagesController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @message = @article.messages.new(message_params)
    
    if @message.save
      render json: {message: @message}
    end
  end
end

private

def message_params
  params.require(:message).permit(:content).merge(user_id: current_user.id, article_id: @article.id)
end 