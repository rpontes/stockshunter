# Will run each hour to get quotations from HG Brasil
set :output, './log/cron_log.log'

every :hour do
  runner 'QuotationWorker.perform_async'
end
