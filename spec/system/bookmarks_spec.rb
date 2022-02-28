require 'rails_helper'

RSpec.describe "お気に入り", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'ログイン前' do
    it '食品検索結果ページの、「星」ボタンを押すとログインページにリダイレクトされる' do
      search_name
      click_button "star", match: :first
      using_wait_time(3) do
        expect(page).to have_content('ログインが必要です')
        expect(page).to have_current_path('/login')
      end
    end
  
    it '食品詳細ページの、「お気に入りに追加」ボタンを押すとログインページにリダイレクトされる' do
      search_name
      find_by_id('food_card', match: :first).click
      click_button 'お気に入りに追加'
      using_wait_time(1) do
        expect(page).to have_content('ログインが必要です')
        expect(page).to have_current_path('/login')
      end
    end
  end

  describe 'ログイン後' do
    before do
      login user
      search_name
    end

    shared_examples_for 'お気に入りページで、お気に入りに追加されている' do
      it {
        click_button 'nav'
        click_link 'bookmark'
        expect(page).to have_content('お気に入り')
        expect(page).to have_selector('#food_card')
      }
    end

    context '食品検索結果ページの「星」ボタンを押す' do
      before do
        click_button "star", match: :first
      end
      it_behaves_like 'お気に入りページで、お気に入りに追加されている'
    end

    context '食品詳細ページの「お気に入りに追加」ボタンを押す' do
      before do
        find_by_id('food_card', match: :first).click
        click_button 'お気に入りに追加'
        click_button '閉じる'
      end
      it_behaves_like 'お気に入りページで、お気に入りに追加されている'
    end

    shared_examples_for 'お気に入りページで「お気に入り食品がありません」が表示されている' do
      it {
        click_button 'nav'
        click_link 'bookmark'
        expect(page).to have_content('お気に入り食品がありません')
        expect(page).to_not have_selector('#food_card')
      }
    end
  
    context '食品検索結果ページの、「星」ボタンを2回押す' do
      before do
        click_button "star", match: :first
        click_button "star", match: :first
      end
      it_behaves_like 'お気に入りページで「お気に入り食品がありません」が表示されている'
    end
  
    context '食品詳細ページの「お気に入りに追加」ボタン押した後、「お気に入りから削除」ボタンを押す' do
      before do
        find_by_id('food_card', match: :first).click
        click_button 'お気に入りに追加'
        click_button 'お気に入りから削除'
        click_button '閉じる'
      end
      it_behaves_like 'お気に入りページで「お気に入り食品がありません」が表示されている'
    end
  end
end
