require 'rails_helper'

RSpec.describe "Foods", type: :system do
  before do
    visit '/search'
  end

  shared_examples_for '商品が出てくる' do
    it {
      expect(page).to have_current_path('/foods')
      expect(page).to have_content('ヒットしました')
      expect(page).to have_selector('#food_card')
    }
  end

  describe '名前検索' do
    context 'フォームに文字を入力し、検索した時' do
      before do
        search_name
      end
      it_behaves_like '商品が出てくる'
    end
    
    it '文字未入力だと検索できない' do
      click_button 'magnify'
      expect(page).to have_current_path('/search')
      expect(page).to have_content("文字を入力してください")
    end
  end

  describe '数値検索' do
    context 'フォームに数値を入力し、検索した時' do
      before do
        search_nutrient
      end
      it_behaves_like '商品が出てくる'
    end

    context 'カロリー計算をすると数値が自動で反映され、検索した時' do
      before do
        visit '/calculation'
        calculating_form_entry
        click_button('計算する')
        visit '/search'
        click_button 'この条件で検索'
      end
      it_behaves_like '商品が出てくる'
    end
    
    shared_examples_for '検索できない' do
      it {
        click_button 'この条件で検索'
        expect(page).to have_current_path('/search')
        expect(page).to have_content('数値を入力してください')
      }
    end
    
    context '文字を入力すると' do
      before do
        fill_in 'proteinMin', with: 'hogehoge'
      end
      it_behaves_like '検索できない'
    end

    context '数値未入力だと' do
      it_behaves_like '検索できない'
    end
  end

  describe '検索結果ページ' do
    it '1件もヒットしないと、メッセージが表示されている' do
      fill_in '名前検索', with: 'コンビニ'
      click_button 'magnify'
      expect(page).to have_content('条件に合致するデータがありません。')
    end
  end
end
