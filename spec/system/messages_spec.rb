require 'rails_helper'

RSpec.describe 'メッセージの投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article)
    Message.create(article_id: @article.id, user_id: @user.id, content: "コメントをよろしくお願いします")
  end
  context 'メッセージが投稿できるとき'do
    it 'ログインしたユーザーは投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name="commit"]').click
      # 投稿された記事の詳細ページに遷移する
      visit article_path(@article.id)
      # フォームに文字を入力する
      expect(page).to have_button '送信'
      fill_in 'message_text_field', with: "テスト"
      # 送信すると同じページに投稿したメッセージが存在することを確認する
      click_on '送信'
      expect(page).to have_content("テスト")
     end
   end
  context 'メッセージ投稿ができないとき'do
    it 'ログインしていないとメッセージ投稿ができない' do
      # トップページに遷移する
      visit root_path
      # 投稿された記事の詳細ページへ遷移する
      visit article_path(@article.id)
      # 送信ボタンが存在しないことを確認する
      expect(page).to have_no_button '送信'
    end
  end
end
