# Model to save daily quotations
class Quotation < ApplicationRecord
  validates :buy, :sell, :variation, :currency_id, presence: true

  belongs_to :currency

  scope :by_day, lambda { |day|
    where(quotation_at: day.beginning_of_day..day.end_of_day)
      .order(:quotation_at)
  }

  def self.last_quotation_at
    quotation = Quotation.select(:quotation_at).order(quotation_at: :desc).first

    return nil unless quotation.present?

    I18.l(quotation.try(:quotation_at), format: :short)
  end
end
