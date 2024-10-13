require "google/cloud/translate"

Google::Cloud::Translate.configure do |config|
    config.project_id  = ENV["GOOGLE_CLOUD_PROJECT_ID"]
    config.credentials = Rails.root.join('config', 'GCP_service_key.json').to_s
end
