class Snack < ApplicationRecord
  validates_presence_of :name, :purchase_location
  validates_uniqueness_of :name
  before_validation :downcase_name

  def downcase_name
    self.name.present? && self.name.downcase!
  end
end
