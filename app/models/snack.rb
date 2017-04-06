class Snack < ApplicationRecord
  validates_presence_of :name, :purchase_location
  validates_uniqueness_of :name
end
