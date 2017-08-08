# Service to access HG Brasil to get currency quotations
class HgBrasilService
  include HTTParty

  OPTIONS = { query: { format: :json, key: ENV['HG_KEY_API'] } }.freeze
  CURRENCIES = %w(USD EUR BTC).freeze

  base_uri 'https://api.hgbrasil.com/finance'

  # Method to request quotations from HGBrasil.
  def quotations
    response = self.class.get('/quotations', OPTIONS)

    return parse_quotations(response) if response.success?

    raise response.response
  end

  private

  # Get api reponse and parse to save on database.
  def parse_quotations(response)
    return [] unless response.key?('results')

    currencies = {}

    response['results']['currencies'].each do |acronym, value|
      next unless CURRENCIES.include?(acronym)

      currencies[acronym.to_sym] = { buy: value['buy'],
                                     sell: value['sell'],
                                     variation: value['variation'] }
    end

    currencies
  end
end
