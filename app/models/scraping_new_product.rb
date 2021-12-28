require 'mechanize'

class ScrapingNewProduct
  # 新商品トップの一覧から、各地方の一覧ページ情報を取得する
  def self.new_seven_urls
    top_links = []
    agent = Mechanize.new
    page = agent.get('https://www.sej.co.jp/products/a/thisweek/')
    elements = page.search('.pbBlock.pbBlockBase a')
    elements.each do |ele|
      break if ele.get_attribute('href') == '/products/area.html'

      top_links << ele.get_attribute('href')
    end

    top_links.each do |link|
      seven_urls(link)
    end
  end

  # 商品詳細のページ情報を取得する
  def self.seven_urls(next_url)
    links = []
    loop do
      agent = Mechanize.new
      current_page = agent.get("https://www.sej.co.jp/#{next_url}")
      elements = current_page.search('.item_ttl p a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      next_link = current_page.at('.pager li:last-child a')

      break unless next_link

      next_url = next_link.get_attribute('href')
    end

    links.each do |link|
      get_food("https://www.sej.co.jp#{link}")
    end
  end

  # データに格納する
  def self.get_food(link)
    agent = Mechanize.new
    page = agent.get(link)

    name = page.at('.item_ttl h1').inner_text if page.at('.item_ttl h1')
    url = page.at('.productWrap img')[:src] if page.at('.productWrap img')
    price = page.at('.item_price p').inner_text.split('円').first.to_i if page.at('.item_price p')

    if page.at('.allergy tr:nth-child(2) td')
      array = page.at('.allergy tr:nth-child(2) td').inner_text.split(/[、（]/).first(4)
      array.map! { |arr| arr.gsub(/[^\d+.\d+]/, '').to_f }
      calorie = array[0]
      protein = array[1]
      lipid = array[2]
      carbohydrate = array[3]
    end

    food = Food.where(name: name)

    return unless food.blank? && protein.present?

    Food.create(name: name,
                remote_image_url: url,
                price: price,
                calorie: calorie,
                protein: protein,
                lipid: lipid,
                carbohydrate: carbohydrate,
                store: 0)
  end
end
