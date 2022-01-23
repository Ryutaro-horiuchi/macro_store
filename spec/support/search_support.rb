module SearchSupport
  def search_name
    visit '/search'
    fill_in '名前検索', with: 'そば'
    click_button 'magnify'
  end

  def search_nutrient
    fill_in 'proteinMin', with: '15'
    fill_in 'proteinMax', with: '25'
    fill_in 'carboMin', with: '55'
    fill_in 'carboMax', with: '65'
    fill_in 'lipidMin', with: '5'
    fill_in 'lipidMax', with: '10'
    click_button 'この条件で検索'
  end

  RSpec.configure do |config|
    config.include SearchSupport
  end
end