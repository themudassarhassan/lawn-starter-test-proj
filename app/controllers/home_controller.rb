class HomeController < ApplicationController
  def index
    results = if search_params_present?
      SwapiSearcher.new(type: resource_type, query: search_query).call
    else
      []
    end

    render inertia: "home/index", props: { results:, query: search_query, resource_type: }
  end

  private

  def search_params_present?
    resource_type.present? && search_query.present?
  end

  def resource_type
    params[:type]
  end

  def search_query
    params[:search_query]
  end
end
