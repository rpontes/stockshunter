namespace :quotations do
  desc 'Rake to access HGBrasil to request quotations'
  task request: :environment do
    QuotationWorker.perform_async
  end
end
