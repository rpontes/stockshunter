# Controller to get all quotations from day and show in a dashboard.
class QuotationsController < ApplicationController
  def index
    today = Time.zone.now

    @quotations = []

    Currency.where(acronym: %w(BTC EUR USD)).each do |currency|
      quotations = currency.quotations.by_day(today)

      @quotations << {
        name: currency.name,
        acronym: currency.acronym,
        labels: quotations.map(&:quotation_at_visual),
        data: parse_chart_data(quotations)
      }
    end

    render json: { data: @quotations }, status: :ok
  end

  private

  def parse_chart_data(quotations)
    return {} unless quotations.present?

    data = []

    quotations.each do |quotation|
      data << quotation.buy.to_f
    end

    data
  end
end
