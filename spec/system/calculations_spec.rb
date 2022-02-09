require 'rails_helper'

RSpec.describe "カロリー計算", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'ログイン前' do
    before do
      visit '/calculation'
    end
    
    context 'カロリー計算' do
      before do
        calculating_form_entry
      end

      context '正常' do
        it '「戻る」ボタンを押すと、トップページに遷移する' do
          click_button '戻る'
          expect(page).to have_current_path('/')
        end
        
        it '「計算する」ボタンが表示される' do
          expect(page).to have_button('計算する')
        end

        it '「計算する」ボタンを押すと、計算結果ページに遷移する' do
          click_button '計算する'
          expect(page).to have_current_path('/result')
        end
      end
    end

    # 選択しない処理がうまくいかないため、以下のようにするが、リファクタリングする
    context '異常' do
      shared_examples_for 'ボタンが表示されない' do
        it { expect(page).to_not have_button('計算する') }
      end

      context '性別を選択しない' do
        before do
          # 年齢を選択
          find('.v-input__append-inner').click
          page.all('.v-list-item__content')[2].click
          # 体重を入力
          fill_in 'weight', with: '70'
          # 運動量を選択
          page.all('.v-input--selection-controls__ripple', visible: false)[3].click
        end
        it_behaves_like 'ボタンが表示されない'
      end

      context '年齢を選択しない' do
        before do
          # 性別を選択
          find('.v-input--selection-controls__ripple', match: :first).set(true)
          # 体重を入力
          fill_in 'weight', with: '70'
          # 運動量を選択
          page.all('.v-input--selection-controls__ripple', visible: false)[3].click
        end
        it_behaves_like 'ボタンが表示されない'
      end

      context '体重を入力しない' do
        before do
          # 性別を選択
          find('.v-input--selection-controls__ripple', match: :first).set(true)
          # 年齢を選択
          find('.v-input__append-inner').click
          page.all('.v-list-item__content')[2].click
          # 運動量を選択
          page.all('.v-input--selection-controls__ripple', visible: false)[3].click
        end
        it_behaves_like 'ボタンが表示されない'
      end

      context '運動量を入力しない'do
        before do
          # 性別を選択
          find('.v-input--selection-controls__ripple', match: :first).set(true)
          # 年齢を選択
          find('.v-input__append-inner').click
          page.all('.v-list-item__content')[2].click
          # 体重を入力
          fill_in 'weight', with: '70'
        end
        it_behaves_like 'ボタンが表示されない'
      end
    end
  end

  describe 'ログイン後' do
    before do
      login user
      visit '/calculation'
      calculating_form_entry
    end

    context 'カロリー計算すると確認モーダルが表示される' do
      before do
        click_button '計算する'
        expect(page).to have_content('今回の計算結果を保存しますか？')
      end

      it '保存するボタンを押すと、ユーザー情報が更新される' do
        click_button '保存する'
        using_wait_time(1) do
          expect(page).to have_content('ユーザー情報を更新しました')
          expect(page).to have_current_path('/mypage')
          tds = all('tbody tr')[0].all('td')
          expect(tds[1]).to have_content('740')
        end
      end

      it '閉じるボタンを押すと、ユーザー情報は変わらない' do
        click_button '閉じる'
        click_button 'nav'
        click_link 'mypage'
        tds = all('tbody tr')[0].all('td')
        expect(tds[1]).to have_content('852')
      end
    end
  end
end
