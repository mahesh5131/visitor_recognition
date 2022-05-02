json.extract! visitor_table, :id, :name, :relation, :classification, :no_of_visits, :last_visited, :notes, :created_at, :updated_at
json.url visitor_table_url(visitor_table, format: :json)
