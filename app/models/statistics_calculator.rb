class StatisticsCalculator
  def self.calculate
    return { error: "No queries found" } if Query.count.zero?

    stats = {}
    stats[:top_five_queries] = calculate_top_queries
    stats[:average_response_time] = calculate_average_response_time
    stats[:most_popular_hour] = calculate_most_popular_hour
    stats[:category_distribution] = calculate_category_distribution

    save_statistics(stats)
    stats
  end

  private

  def self.calculate_top_queries
    total_queries = Query.count
    top_five_queries = Query.group(:query_text)
                           .order(count_all: :desc)
                           .limit(5)
                           .count

    top_five_queries.map do |query, count|
      percentage = (count.to_f / total_queries * 100).round(2)
      { query: query, percentage: percentage }
    end
  end

  def self.calculate_average_response_time
    Query.average(:response_time).to_f.round(2)
  end

  def self.calculate_most_popular_hour
    most_popular_hour = Query.group("strftime('%H', created_at)")
                             .order(count_all: :desc)
                             .limit(1)
                             .count.first

    {
      hour: most_popular_hour&.first.to_i,
      count: most_popular_hour&.last.to_i
    }
  end

  def self.calculate_category_distribution
    category_counts = Query.group(:resource_type).count
    total = category_counts.values.sum

    category_counts.transform_values do |count|
      (count.to_f / total * 100).round(2)
    end
  end

  def self.save_statistics(stats)
    statistic = Statistic.first_or_initialize
    statistic.data = stats
    statistic.save!
  end
end
