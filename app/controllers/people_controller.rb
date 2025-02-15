class PeopleController < ApplicationController
  def show
    person = SwapiService.get_person(params[:id])

    person["films"] = fetch_person_films(person["films"])

    render inertia: "people/show", props: { person: }
  end

  private

  def fetch_person_films(film_uris)
    film_uris.map do |film_uri|
      film_id = extract_film_id(film_uri)
      film = SwapiService.get_film(film_id)

      { label: film["title"], href: film_path(film_id) }
    end
  end

  def extract_film_id(film_uri)
    URI(film_uri).path.split("/").last
  end
end
