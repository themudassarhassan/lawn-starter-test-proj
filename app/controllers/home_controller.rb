class HomeController < ApplicationController
  def index
    results = if search_params_present?
      SwapiSearcher.new(type: resource_type, query:).call
    else
      []
    end

    render inertia: "home/index", props: { results:, query:, resource_type: }
  end

  private

  def search_params_present?
    resource_type.present? && query.present?
  end

  def resource_type
    params[:resourceType]
  end

  def query
    params[:query]
  end
end
