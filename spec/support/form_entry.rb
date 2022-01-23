module FormEntry
  def calculating_form_entry
    # 性別を選択
    find('.v-input--selection-controls__ripple', visible: false, match: :first).set(true)
    # 年齢を選択
    find('.v-input__append-inner', visible: false).click
    page.all('.v-list-item__content')[2].click
    # 体重を入力
    fill_in 'weight', with: '70'
    # 運動量を選択
    page.all('.v-input--selection-controls__ripple', visible: false)[3].click
  end

  RSpec.configure do |config|
    config.include FormEntry
  end
end