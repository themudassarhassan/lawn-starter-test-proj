require "net/http"
require "json"

class SwapiService
  class UnknownResourceType < StandardError
  end

  BASE_URL = "https://swapi.py4e.com/api".freeze
  PEOPLE = "people".freeze
  FILMS = "films".freeze

  VALID_TYPES = [ PEOPLE, FILMS ]

  class << self
    def get_all(type, search_query: "")
      raise UnknownResourceType unless VALID_TYPES.include?(type)

      fetch type, search_query:
    end

    def get_person(person_id)
      with_cache("person_#{person_id}") { fetch PEOPLE, id: person_id }
    end

    def get_film(film_id)
      with_cache("film_#{film_id}") { fetch FILMS, id: film_id }
    end

    private


    def fetch(type, id: nil, search_query: nil)
      url = if id.nil?
        "#{BASE_URL}/#{type}/?search=#{search_query}"
      else
        "#{BASE_URL}/#{type}/#{id}/"
      end

      uri = URI(url)
      response = Net::HTTP.get_response(uri)

      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        { error: "Failed to fetch data", status: response.code }
      end
    end


    def with_cache(key, expires_in: 12.hours)
      Rails.cache.fetch(key, expires_in:) do
        yield
      end
    end
  end
end
