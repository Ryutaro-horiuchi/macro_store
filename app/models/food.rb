class Food < ApplicationRecord
  mount_uploader :image, ImageUploader
  enum store: { seven_eleven: 0, family_mart: 1, lawson: 2 }
  has_many :bookmarks, dependent: :destroy

  scope :protein_bitween, -> minimum, maximum {
    maximum.present? ? where(protein: minimum..maximum) : where(protein: minimum..)
  }
  scope :carbohydrate_bitween, -> minimum, maximum { 
    maximum.present? ? where(carbohydrate: minimum..maximum) : where(carbohydrate: minimum..)
  }
  scope :lipid_bitween, -> minimum, maximum { 
    maximum.present? ? where(lipid: minimum..maximum) : where(lipid: minimum..)
  }
end
