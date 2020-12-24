require 'rails_helper'

RSpec.describe '記事の投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.build(:article_tag_table)
  end
  context '記事の投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Login')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクをクリックする
      click_on("投　稿")
      # フォームに入力する
      select "憲法", from: "科目"
      fill_in 'article_tag_table_title', with: @article.title
      fill_in 'article_tag_table_text', with: @article.text
      # 送信するとArticleモデルのカウントが1上がることを確認する
      expect{
        click_on("保存する")
      }.to change { Article.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する
      expect(page).to have_content(@article.title)
    end
  end
  context '記事の投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクをクリックすると、ログイン画面に遷移する
      click_on("投　稿")
      expect(current_path).to eq new_user_session_path
    end
  end
end


RSpec.describe '投稿記事の削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.create(:user)
    @article = FactoryBot.build(:article_tag_table)
  end
  context '投稿記事の削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した記事の削除ができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Login')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクをクリックする
      click_on("投　稿")
      # フォームに入力して保存する
      select "憲法", from: "科目"
      fill_in 'article_tag_table_title', with: @article.title
      fill_in 'article_tag_table_text', with: @article.text
      click_on("保存する")
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # 自分の投稿した記事の詳細画面に遷移する
      expect(page).to have_content("Rspecタイトル")
      click_on("Rspecタイトル")
      # 削除ボタンが存在することを確認する
      expect(page).to have_content("削除")
      # 削除ボタンをクリックして削除するとレコードの数が1減ることを確認する
      page.accept_confirm do
        click_on("削除")
      end
      # トップページに遷移する
      visit root_path
    end
  end
  context '投稿記事の削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した記事の削除ができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Login')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクをクリックする
      click_on("投　稿")
      # フォームに入力して保存する
      select "憲法", from: "科目"
      fill_in 'article_tag_table_title', with: @article.title
      fill_in 'article_tag_table_text', with: @article.text
      click_on("保存する")
      # 他のユーザーが先ほど投稿した記事の詳細ページに遷移し、削除ボタンが無いことを確認する
      click_on("Logout")
      visit new_user_session_path
      fill_in 'user_email', with: @another.email
      fill_in 'user_password', with: @another.password
      find('input[name="commit"]').click
      expect(page).to have_content("Rspecタイトル")
      click_on("Rspecタイトル")
      expect(page).to have_no_content("削除")
    end
    it 'ログインしていないと投稿記事の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Login')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクをクリックする
      click_on("投　稿")
      # フォームに入力して保存する
      select "憲法", from: "科目"
      fill_in 'article_tag_table_title', with: @article.title
      fill_in 'article_tag_table_text', with: @article.text
      click_on("保存する")
      # ログアウトする
      click_on("Logout")
      # 先ほど投稿した記事の詳細画面に遷移する
      expect(page).to have_content("Rspecタイトル")
      click_on("Rspecタイトル")
      # 削除ボタンが存在しないことを確認する
      expect(page).to have_no_content("削除")
    end
  end
end

RSpec.describe '投稿記事の詳細画面', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.create(:user)
    @article = FactoryBot.build(:article_tag_table)
  end
  it 'ログインしたユーザーは自分の投稿した記事の詳細ページに遷移してメッセージ投稿欄が表示される' do
    # トップページに移動する
    visit root_path
    # トップページにログインページへ遷移するボタンがあることを確認する
    expect(page).to have_content('Login')
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいユーザー情報を入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンを押す
    find('input[name="commit"]').click
    # トップページへ遷移することを確認する
    expect(current_path).to eq root_path
    # 新規投稿ページへのリンクをクリックする
    click_on("投　稿")
    # フォームに入力して保存する
    select "憲法", from: "科目"
    fill_in 'article_tag_table_title', with: @article.title
    fill_in 'article_tag_table_text', with: @article.text
    click_on("保存する")
    # トップページに遷移することを確認する
    expect(current_path).to eq root_path     
    # 先ほど投稿した記事の詳細画面に遷移する
    expect(page).to have_content("Rspecタイトル")
    click_on("Rspecタイトル")
    # 送信ボタンが存在することを確認する
    expect(page).to have_button '送信'
  end
  it 'ログインしている状態の他のユーザーが、自分が投稿した記事の詳細ページに遷移するとメッセージ投稿欄が表示される' do
    # トップページに移動する
    visit root_path
    # トップページにログインページへ遷移するボタンがあることを確認する
    expect(page).to have_content('Login')
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいユーザー情報を入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンを押す
    find('input[name="commit"]').click
    # トップページへ遷移することを確認する
    expect(current_path).to eq root_path
    # 新規投稿ページへのリンクをクリックする
    click_on("投　稿")
    # フォームに入力して保存する
    select "憲法", from: "科目"
    fill_in 'article_tag_table_title', with: @article.title
    fill_in 'article_tag_table_text', with: @article.text
    click_on("保存する")
    # 先ほど作成した投稿記事の詳細画面に他のユーザーが遷移した場合、メッセージ投稿欄が表示される
    click_on("Logout")
    visit new_user_session_path
    fill_in 'user_email', with: @another.email
    fill_in 'user_password', with: @another.password
    find('input[name="commit"]').click
    expect(page).to have_content("Rspecタイトル")
    click_on("Rspecタイトル")
    expect(page).to have_button '送信'
  end

  it 'ログインしていない状態で投稿詳細詳細ページに遷移できるもののメッセージ投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # トップページにログインページへ遷移するボタンがあることを確認する
    expect(page).to have_content('Login')
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいユーザー情報を入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンを押す
    find('input[name="commit"]').click
    # トップページへ遷移することを確認する
    expect(current_path).to eq root_path
    # 新規投稿ページへのリンクをクリックする
    click_on("投　稿")
    # フォームに入力して保存する
    select "憲法", from: "科目"
    fill_in 'article_tag_table_title', with: @article.title
    fill_in 'article_tag_table_text', with: @article.text
    click_on("保存する")
    # トップページに遷移することを確認する
    expect(current_path).to eq root_path
    # ログアウトする
    click_on("Logout")
    # 先ほど投稿した記事の詳細画面に遷移する
    expect(page).to have_content("Rspecタイトル")
    click_on("Rspecタイトル")
    # 送信ボタンが存在しないことを確認する
    expect(page).to have_no_button '送信'
  end
end
