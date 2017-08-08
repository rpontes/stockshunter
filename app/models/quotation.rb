# Model to save daily quotations
class Quotation < ApplicationRecord
  validates :buy, :sell, :variation, :currency_id, presence: true

  belongs_to :currency

  scope :by_day, lambda { |day|
    where(quotations: { quotation_at: day.beginning_of_day...day.end_of_day })
      .order(:quotation_at)
  }

  scope :by_hour, lambda { |day|
    where(quotations: { quotation_at: day.beginning_of_hour...day.end_of_hour })
      .order(:quotation_at)
  }

  # Method to get last quotation to show on Dashboard.
  def self.last_quotation_at
    quotation = Quotation.select(:quotation_at).order(quotation_at: :desc).first

    return nil unless quotation.present?

    I18n.l(quotation.quotation_at, format: :short)
  end

  # Method to return quotation_at formated.
  def quotation_at_visual
    quotation_at.strftime('%d/%m/%y %H:00')
  end
end
