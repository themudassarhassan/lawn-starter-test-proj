class FilmsController < ApplicationController
  def show
    film = SwapiService.get_film params[:id]

    film['characters'] = fetch_film_characters(film['characters'])
    
    render inertia: "films/show", props: { film: }
  end
  
  private
  
  def fetch_film_characters(character_uris)
    character_uris.map do |character_uri|
      character_id = extract_character_id(character_uri)

      character = SwapiService.get_person character_id

      { label: character["name"], href: person_path(character_id) }
    end
  end
  
  def extract_character_id(character_uri)
    URI(character_uri).path.split("/").last
  end
end
