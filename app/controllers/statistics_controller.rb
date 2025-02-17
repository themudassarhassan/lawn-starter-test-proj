class StatisticsController < ApplicationController
  def index
    statistic = Statistic.first

    if statistic.nil?
      data = StatisticsCalculator.calculate
    else
      data = statistic.data
    end

    render json: data
  end
end
