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
    # 商品詳細情報のリンクのタグを指定して、要素を全てelementsに格納する
    # elementsの一つ一つからhref属性を指定して属性値であるurlを抜き出し、linksに保存
    loop do
      agent = Mechanize.new
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

    if page.at('.item_price p')
      price_strings = page.at('.item_price p').inner_text
      letter = price_strings.split('円')
      price = letter.first.to_i
    end

    if page.at('.allergy tr:nth-child(2) td')
      array = page.at('.allergy tr:nth-child(2) td').inner_text
      array = array.split(/[、（]/).first(4)
      array.map! { |arr| arr.gsub(/[^\d+.\d+]/, '').to_f }
      calorie = array[0]
      protein = array[1]
      lipid = array[2]
      carbohydrate = array[3]
    end

    food = Food.where(name: name)

    # もし該当しなければ、保存する
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
