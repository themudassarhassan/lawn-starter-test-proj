import { Link } from "@inertiajs/react"
import { renderCommaSeperatedLinks } from '../../helpers'

export default function Show({ person }) {

  return (
    <div className="shadow-md mt-3 px-6 py-6  bg-white rounded min-h-[500px] relative">
      <h1 className="font-bold">{person.name}</h1>

      <div className="flex gap-x-3 justify-between">
        <section className="flex-1">
          <h2 className="border-b py-2 mb-2 font-bold border-gray-300">Details</h2>
          <p className="font-light text-sm">Birth Year: {person.birth_year}</p>
          <p className="font-light text-sm">Gender: {person.gender}</p>
          <p className="font-light text-sm">Eye Color: {person.eye_color}</p>
          <p className="font-light text-sm">Hair Color: {person.hair_color}</p>
          <p className="font-light text-sm">Height: {person.height}</p>
          <p className="font-light text-sm">Mass: {person.mass}</p>
        </section>

        <section className="flex-1">
          <h2 className="border-b py-2 font-bold border-gray-300">Movies</h2>

          {renderCommaSeperatedLinks(person.films)}
        </section>
      </div>

      <Link className="uppercase absolute bottom-5 text-white bg-green-500 hover:bg-green-600 px-6 py-2 mt-2 rounded-4xl" href="/" as="button">Back to search</Link>
    </div>
  )
}


