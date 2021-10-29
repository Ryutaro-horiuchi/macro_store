class Food < ApplicationRecord
  enum store: { seven_eleven: 0, family_mart: 1, lawson: 2 }
end
