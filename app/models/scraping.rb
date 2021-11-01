require 'mechanize'

class Scraping
  def self.seven_urls
    agent = Mechanize.new
    links = []
    next_url = "products/a/chukaman"

    while true
      current_page = agent.get('https://www.sej.co.jp/' + next_url)
      elements = current_page.search('.item_ttl p a')
      # 取得したいリンクのタグを指定し、全てelementsに格納する
      elements.each do |ele|
        links << ele.get_attribute('href')
      end
      # elementsの一つ一つからhref属性を指定してurlを抜き出し、linksに保存
      
      next_link = current_page.at('.pager li:last-child a')
      # 次のページのリンクを取得する。
      break unless next_link
      # なければ終了する
      next_url = next_link.get_attribute('href')
      # href属性からurlを取得し、next_urlに代入し、初めに戻る
    end

    links.each do |link|
      get_food('https://www.sej.co.jp' + link)
    end
  end

  # 全ての商品詳細urlを取得することができたら
  def self.get_food(link)
    # puts link リンクは取得できている
    agent = Mechanize.new
    page = agent.get(link)

    name = page.at('.item_ttl h1').inner_text if page.at('.item_ttl h1') #ok
    url = page.at('.productWrap img')[:src] if page.at('.productWrap img')

    if page.at('.item_price p') #ok
      price_strings = page.at('.item_price p').inner_text
      letter = price_strings.split("円")
      price = letter.first.to_i
    end
    
    if page.at('.allergy td') #ok
      array = page.at('.allergy tr:nth-child(2) td').inner_text
      array = array.split(/[、（]/)
      array = array.first(4)
      array.map! { |arr| arr.gsub(/[^\d+\.\d+]/, "").to_f }
      calorie = array[0]
      protein = array[1]
      lipid = array[2]
      carbohydrate = array[3]
    end

    food = Food.where(name: name)
    if food.blank? && protein.present?
      # もし該当しなければ、保存する
      food = Food.new
      food.name = name
      food.remote_image_url = url
      food.price = price
      food.calorie = calorie
      food.protein = protein
      food.lipid = lipid
      food.carbohydrate = carbohydrate
      food.store = 0
      food.save
    end
  end
end
