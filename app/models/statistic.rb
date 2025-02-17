require "json"

class Statistic < ApplicationRecord
  serialize :data, coder: JSON

  validates :data, presence: true
end
