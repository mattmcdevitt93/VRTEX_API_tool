json.extract! timesheet, :id, :event, :event_time, :user_id, :urgency, :notes, :created_at, :updated_at
json.url timesheet_url(timesheet, format: :json)