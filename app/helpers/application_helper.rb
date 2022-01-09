module ApplicationHelper
  def default_meta_tags
    {
      site: 'MacroStore(マクロストア) | コンビニ食品で簡単ダイエット',
      charset: 'utf-8',
      description: 'ついつい食事はコンビニ食品...でも太りたくない...そんなあなたにMacroStore(マクロストア)。4つの質問に答えるだけで、ダイエットに最適なカロリーとPFCバランスを提案。その数値に見合ったコンビニ食品を検索できるサービスです。MacroStoreで、理想の体を手に入れましょう！',
      canonical: 'https://www.macrostore.jp',
      icon: image_url('favicon.png'),
      og: {
        title: :full_title,
        description: '4つの質問に答えるだけで、ダイエットに最適なカロリー（PFC）を提案。数値を元にコンビニ食品を検索できるサービスです。',
        url: 'https://www.macrostore.jp',
        image: image_url('MacroStore_ogp.png')
      },
      twitter: {
        card: 'summary_large_image'
      }
    }
  end
end
