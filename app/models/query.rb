class Query < ApplicationRecord
  validates :query_text, presence: true
  validates :resource_type, presence: true, inclusion: { in: [ "people", "films" ] }
  validates :response_time, presence: true, numericality: { greater_than: 0 }
end
