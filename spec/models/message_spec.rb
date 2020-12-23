require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end
  describe 'メッセージの保存' do
    it 'contentが空でなければ保存出来る' do
      expect(@message).to be_valid
    end
    it 'contentが空の場合保存できない' do
      @message.content = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Contentを入力してください")
    end
  end
end  
