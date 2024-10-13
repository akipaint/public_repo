class InterestTagMaintenanceJob < ApplicationJob
    queue_as :default

    def perform
    InterestTagService.perform_daily_maintenance
    end
end
