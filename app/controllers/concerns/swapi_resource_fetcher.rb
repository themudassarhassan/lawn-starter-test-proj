module SwapiResourceFetcher
  extend ActiveSupport::Concern

  private

  def fetch_related_resources(uris, resource_type, label_key, path_helper_method)
    promises = uris.map do |uri|
      Concurrent::Promise.execute do
        resource_id = extract_resource_id(uri)

        resource = case resource_type
        when :film
                     SwapiService.get_film(resource_id)
        when :person
                     SwapiService.get_person(resource_id)
        end

        { label: resource[label_key], href: send(path_helper_method, resource_id) }
      end
    end

    promises.map(&:value!)
  end

  def extract_resource_id(uri)
    URI(uri).path.split("/").last
  end
end
