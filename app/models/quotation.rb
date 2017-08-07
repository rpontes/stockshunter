# Model to save daily quotations
class Quotation < ApplicationRecord
  validates :buy, :sell, :variation, :currency_id, presence: true

  belongs_to :currency

  scope :by_day, lambda { |day|
    where(quotation_at: day.beginning_of_day..day.end_of_day)
      .order(:quotation_at)
  }

  def self.last_quotation_at
    Quotation.select(:quotation_at)
             .order(quotation_at: :desc)
             .first.quotation_at
  end
end
