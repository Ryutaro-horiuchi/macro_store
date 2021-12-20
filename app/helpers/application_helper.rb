module ApplicationHelper
  def default_meta_tags
    {
      site: 'MacroStore(マクロストア)〜コンビニ食品で簡単ダイエット〜',
      charset:'utf-8',
      description: 'ついつい食事はコンビニ食品...でも太りたくない...そんなあなたにMactoStore(マクロストア)。2ステップを踏むだけで、ダイエットに最適なカロリーとPFCバランスを提案。その数値に見合ったコンビニ食品を検索できるサービスです',
      canonical: 'https://macro-store.herokuapp.com',
      # icon: [
      # ],
      og: {
      title: :full_title,
      description: :description,
      url: 'https://macro-store.herokuapp.com',
      image: image_url('shellfish-pasta-pizza-and-italian-food.jpg'),
      },
      twitter: {
        card: 'summary',
        site: '@yorutaru097'
      }
    }
  end
end
