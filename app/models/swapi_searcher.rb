class SwapiSearcher
  include Rails.application.routes.url_helpers

  VALID_TYPES = %w[people films].freeze

  attr_reader :type, :query

  def initialize(type:, query:)
    @type = type.to_s.downcase
    @query = query.to_s.strip
    validate_inputs!
  end

  def call
    return [] if query.empty?

    start_time = Time.now

    search_results = fetch_results

    duration = (Time.now - start_time) * 1000

    create_query_record(duration)

    parse_results(search_results)
  end

  private

  def validate_inputs!
    raise ArgumentError, "Invalid search type: #{type}. Valid types are: #{VALID_TYPES.join(', ')}" unless VALID_TYPES.include?(type)
  end

  def fetch_results
    SwapiService.get_all(type, search_query: query)
  end

  def create_query_record(duration)
    Query.create!(
      query_text: query,
      resource_type: type,
      response_time: duration
    )
  end

  def parse_results(response)
    return [] unless response && response["results"]

    response["results"].map do |item|
      {
        title: item["title"],
        name: item["name"],
        url: generate_url(item["url"])
      }.compact
    end
  end

  def generate_url(url)
    path = URI(url).path
    id = path.split("/").last

    type === "films" ? film_path(id) : person_path(id)
  end
end
