# Class to save currencies
class Currency < ApplicationRecord
  validates :name, :acronym, presence: true

  has_many :quotations
end
