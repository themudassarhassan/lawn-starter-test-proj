class FilmsController < ApplicationController
  include SwapiResourceFetcher

  def show
    film = SwapiService.get_film params[:id]

    film["characters"] = fetch_film_characters(film["characters"])

    render inertia: "films/show", props: { film: }
  end

  private

  def fetch_film_characters(character_uris)
    fetch_related_resources(character_uris, :person, "name", :person_path)
  end
end
