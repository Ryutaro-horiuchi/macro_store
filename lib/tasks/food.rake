namespace :food do
  desc "セブンイレブンの新商品をデータベースに格納"
  task scraping: :environment do
     ScrapingNewProduct.new_seven_urls
  end
end