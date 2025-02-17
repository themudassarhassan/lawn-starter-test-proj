class CalculateStatisticsJob < ApplicationJob
  def perform
    StatisticsCalculator.calculate
  end
end
