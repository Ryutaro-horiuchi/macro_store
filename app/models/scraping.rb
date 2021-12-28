require 'mechanize'

class Scraping
  def self.seven_urls
    agent = Mechanize.new
    links = []
    next_url = 'products/a/cat/010010010000000/'

    # 商品一覧から商品詳細のリンクを取得し、linksに格納する
    loop do
      current_page = agent.get("https://www.sej.co.jp/#{next_url}")
      elements = current_page.search('.item_ttl p a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      # 次のページのリンクを取得する。
      next_link = current_page.at('.pager li:last-child a')

      # なければ終了する
      break unless next_link

      # href属性からurlを取得し、next_urlに代入し、初めに戻る
      next_url = next_link.get_attribute('href')
    end

    # get_foodメソッドから商品情報を取得する
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
