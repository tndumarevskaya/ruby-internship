json.extract! report, :id, :name, :body, :status, :report_type, :created_at, :updated_at
json.url report_url(report, format: :json)
