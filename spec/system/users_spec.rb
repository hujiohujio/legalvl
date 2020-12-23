require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: @user.nickname
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation      
      # 新規登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
      find('input[name="commit"]').click
      }.to change { User.count }.by(1)      
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # Logoutボタンが表示されることを確認する
      expect(page).to have_content("Logout")
      # 新規登録ページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('Login')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: ""
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""     
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq "/users"
    end
  end

end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
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
      # Logoutボタンが表示されることを確認する
      expect(page).to have_content("Logout")
      # 新規登録ページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('Login')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Login')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe 'ユーザー情報の編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.create(:user)
  end
  context 'ユーザー情報の編集ができるとき' do
    it 'ログインしたユーザーは自分がのユーザー情報の編集ができる' do
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
      # MyPageボタンをクリックし、マイページへ遷移する
      click_on("MyPage")
      # Editボタンがあることを確認し、クリックして編集ページに遷移する
      expect(page).to have_button("Edit")
      click_link("Edit")
      expect(current_path).to eq edit_user_path(@user.id)
      # ユーザー情報を編集する
      fill_in 'user_nickname', with: "ニックネーム編集"
      fill_in 'user_profile', with: "プロフィール編集"
      select '民法', from: '得意科目'
      select '憲法', from: '苦手科目'
      # 編集してもUserモデルのカウントは変わらないことを確認する
      expect{
        click_on("O K")
      }.to change { User.count }.by(0)
      # ユーザー情報詳細ページに遷移することを確認する
      expect(current_path).to eq user_path(@user.id)
      # 編集した内容が表示されていることを確認する
      expect(page).to have_content("ニックネーム編集")
      expect(page).to have_content("プロフィール編集")
      expect(page).to have_content("民法")
      expect(page).to have_content("憲法")
    end
  end
  context 'ユーザー情報の編集ができないとき' do
    it 'ログインしたユーザーは自分以外のユーザーの編集ページには遷移できない' do
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
      # 他のユーザーの投稿記事の詳細画面に遷移する
      visit user_path(@another.id)
      # Editボタンが存在しないことを確認する
      expect(page).to have_no_button("Edit")
      # 他のユーザーのユーザー情報編集画面に直接遷移しようとしても、トップページに戻ることを確認する
      visit edit_user_path(@another.id)
      expect(current_path).to eq root_path
    end
    it 'ログインしていないユーザーは他の人のユーザー情報編集ページには遷移できない' do
      # トップページに移動する
      visit root_path
      # トップページにLoginボタンがあることを確認する
      expect(page).to have_content("Login")
      # 他のユーザーの情報詳細ページに遷移する
      visit user_path(@user.id)
      # Editボタンが存在しないことを確認する
      expect(page).to have_no_button("Edit")
      # 他のユーザーのユーザー情報編集画面に直接遷移しようとしても、トップページに戻ることを確認する
      visit edit_user_path(@user.id)
      expect(current_path).to eq root_path
    end
  end
end

RSpec.describe 'ユーザー情報削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @another = FactoryBot.create(:user)
  end
  context 'ユーザー情報を削除ができるとき' do
    it 'ログインしたユーザーは自らのユーザー情報の削除ができる' do
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
      # MyPageボタンをクリックし、マイページへ遷移する
      click_on("MyPage")
      # Dleteボタンがあることを確認し、クリックして削除するとレコードの数が1減ることを確認する
      expect(page).to have_button("Delete")
      page.accept_confirm do
        click_link("Delete")
      end
      # トップページに遷移することを確認する
      expect(current_path).to eq root_path
      # トップページには新規登録ボタンがあることを確認する
      expect(page).to have_content("新規登録")
    end
  end
  context 'ユーザー情報の削除ができないとき' do
    it 'ログインしたユーザーは自分以外のユーザー情報の削除ができない' do
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
      # 他のユーザーのユーザー情報詳細ページに遷移する
      visit user_path(@another.id)
      # Deleteボタンが存在しないことを確認する
      expect(page).to have_no_button("Delete")
    end
    it 'ログインしていないユーザーは他のユーザーの情報詳細ページに遷移しても削除できない' do
      # トップページに移動する
      visit root_path
      # トップページにLoginボタンがあることを確認する
      expect(page).to have_content('Login')
      # 他のユーザーの情報詳細ページに遷移する
      visit user_path(@user.id)
      # Deleteボタンが存在しないことを確認する
      expect(page).to have_no_button("Delete")
    end
  end
end