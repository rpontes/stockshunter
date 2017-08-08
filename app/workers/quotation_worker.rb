# Worker to call HG Brasil to get quotations and save on local database.
class QuotationWorker
  include Sidekiq::Worker

  def initialize
    @service = HgBrasilService.new
    @today = Time.zone.now
  end

  # Will execute in background to get quotations and save on database.
  def perform
    quotations = @service.quotations

    quotations.each do |key, value|
      currency = Currency.find_by(acronym: key)

      # Discard when exists quotations at same hour
      next if currency.quotations.by_hour(@today).present?

      currency.quotations.create(buy: value[:buy].to_f,
                                 sell: value[:sell].to_f,
                                 variation: value[:variation].to_f,
                                 quotation_at: @today)
    end
  end
end
