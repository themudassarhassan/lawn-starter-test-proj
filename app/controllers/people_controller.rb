class PeopleController < ApplicationController
  include SwapiResourceFetcher

  def show
    person = SwapiService.get_person(params[:id])

    person["films"] = fetch_person_films(person["films"])

    render inertia: "people/show", props: { person: }
  end

  private

  def fetch_person_films(film_uris)
    fetch_related_resources(film_uris, :film, "title", :film_path)
  end
end
