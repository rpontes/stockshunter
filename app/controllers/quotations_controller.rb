# Controller to get all quotations from day
class QuotationsController < ApplicationController
  def index
    today = Time.zone.now

    @quotations = []

    Currency.where(acronym: %w(BTC EUR USD)).each do |currency|
      quotations = currency.quotations.by_day(today)

      @quotations << {
        name: currency.name,
        acronym: currency.acronym,
        data: parse_chart_data(quotations)
      }
    end
  end

  private

  def parse_chart_data(quotations)
    return {} unless quotations.present?

    data = {}

    quotations.each do |quotation|
      at = quotation.quotation_at.strftime('%d/%m/%y - %H:%M')

      data[at] = quotation.buy
    end

    data
  end
end
