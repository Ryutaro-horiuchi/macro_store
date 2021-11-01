class Food < ApplicationRecord
  mount_uploader :image, ImageUploader
  enum store: { seven_eleven: 0, family_mart: 1, lawson: 2 }
end
