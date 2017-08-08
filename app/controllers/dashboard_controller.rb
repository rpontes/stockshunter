# Controller to get all quotations from day and show in a dashboard.
class DashboardController < ApplicationController
  def index
    today = Time.zone.now

    @currencies = []

    Currency.where(acronym: %w(BTC EUR USD)).each do |currency|
      quotations = currency.quotations.by_day(today)

      @currencies << {
        name: currency.name,
        acronym: currency.acronym,
        labels: quotations.map(&:quotation_at_visual),
        quotations: quotations
      }
    end
  end
end
