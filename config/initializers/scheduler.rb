require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

# 毎日深夜3時に実行
scheduler.cron '0 3 * * *' do
    InterestTagMaintenanceJob.perform_later
end
