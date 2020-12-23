require 'rails_helper'

RSpec.describe ArticleTagTable, type: :model do
  before do
    @article_tag_table = FactoryBot.build(:article_tag_table)
  end
  describe '投稿内容の保存' do
    it '全ての値が入力されていれば保存できる' do
      expect(@article_tag_table).to be_valid
    end
    it 'subjが空の場合保存できない' do
      @article_tag_table.subj = nil
      @article_tag_table.valid?
      expect(@article_tag_table.errors.full_messages).to include("Subjを入力してください")
    end
    it 'textが空の場合保存できない' do
      @article_tag_table.text = nil
      @article_tag_table.valid?
      expect(@article_tag_table.errors.full_messages).to include('Textを入力してください')
    end
    it 'titleが空の場合保存できない' do
      @article_tag_table.title = nil
      @article_tag_table.valid?
      expect(@article_tag_table.errors.full_messages).to include("Titleを入力してください")
    end
  end
end
