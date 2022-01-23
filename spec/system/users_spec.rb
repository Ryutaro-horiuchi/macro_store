require 'rails_helper'

RSpec.describe "ユーザー", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'ログイン前' do
    before do
      visit root_path
    end

    it 'ヘッダーに、ログインアイコンが表示されている' do
      expect(page).to have_button 'login'
    end
  
    it 'マイページに遷移したら、ログインページにリダイレクトされる' do
      click_button 'nav'
      click_link 'mypage'
      expect(page).to have_content 'ログインが必要です'
      expect(page).to have_current_path('/login')
    end
  
    it 'お気に入り食品ページに遷移したら、ログインページにリダイレクトされる' do
      click_button 'nav'
      click_link 'bookmark'
      expect(page).to have_content 'ログインが必要です'
      expect(page).to have_current_path('/login')
    end

    describe 'ユーザー新規登録' do
      before do
        click_button 'login'
        click_link 'こちら'
      end

      describe 'フォーム入力' do
        before do
          fill_in 'ユーザー名', with: 'hoge'
          fill_in 'メールアドレス', with: 'hogehoge@example.com'
          fill_in 'パスワード', with: 'hogehoge'
          fill_in 'パスワード (確認用)', with: 'hogehoge' 
        end
        
        context '正常' do
          it '「登録する」ボタンが表示されている' do
            expect(page).to have_button('登録する')
          end
        
          it '登録されている' do
            click_button '登録する'
            using_wait_time(1) do 
              expect(page).to have_content('ユーザー登録が完了しました、ログインしてください')
              expect(page).to have_current_path('/login')
            end
          end
        end

        context '異常' do
          it 'ユーザー名が有効でない時、「登録する」ボタンが表示されていない' do
            fill_in 'ユーザー名', with: 'hogehogehogehogehogehogehogehoge'
            expect(page).to_not have_button('登録する')
          end

          it 'メールアドレスが有効でない時、「登録する」ボタンが表示されていない' do
            fill_in 'メールアドレス', with: 'hogehoge'
            expect(page).to_not have_button('登録する')
          end

          it 'パスワードが有効でない時、「登録する」ボタンが表示されていない' do
            fill_in 'パスワード', with: 'fuga'
            expect(page).to_not have_button('登録する')
          end

          it 'パスワード (確認用)が有効でない時、「登録する」ボタンが表示されていない' do
            fill_in 'パスワード (確認用)', with: 'fugafuga'
            expect(page).to_not have_button('登録する')
          end
        end
      end
    end

    describe 'ログイン' do
      before do
        visit '/login'
      end

      context 'フォーム入力正常' do
        before do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: '12345678'
        end

        it '「ログインする」ボタンが表示されている' do
          expect(page).to have_button 'ログインする'
        end

        it 'ボタンを押すと登録済みのユーザーでログインができる' do
          click_button 'ログインする'
          using_wait_time(1) do 
            expect(page).to have_content('ログインしました')
            expect(page).to have_current_path root_path
          end
        end
      end

      context 'フォーム入力異常' do
        it '「ログインする」ボタンが表示されていない' do
          fill_in 'メールアドレス', with: 'hogehoge'
          fill_in 'パスワード', with: '12345678'
          expect(page).to_not have_button 'ログインする'
        end
      end
      
      it '非登録のユーザーでログインできない' do
        fill_in 'メールアドレス', with: 'hogehoge@i.com'
        fill_in 'パスワード', with: '12345678'
        click_button 'ログインする'
        using_wait_time(1) do 
          expect(page).to have_content('ログインに失敗しました')
          expect(page).to_not have_current_path root_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before do
      login user
    end

    it 'ヘッダーに、ログアウトアイコンが表示されている' do
      expect(page).to have_button 'logout'
    end
    
    it 'ログアウトできる' do
      click_button 'logout'
      expect(page.accept_confirm).to eq ('ログアウトしてもよろしいですか？')
      using_wait_time(1) do 
        expect(page).to have_content('ログアウトしました')
      end
    end
  
    it 'マイページに遷移できる' do
      click_button 'nav'
      click_link 'mypage'
      expect(page).to have_current_path('/mypage')
    end
  
    it 'お気に入り食品ページに遷移できる' do
      click_button 'nav'
      click_link 'bookmark'
      expect(page).to have_current_path('/bookmark')
    end
  end
end
