import { Link } from "@inertiajs/react";
import { renderCommaSeperatedLinks } from "../../helpers";

export default function Show({ film }) {
  
  return (
    <div className="shadow-md mt-3 px-6 py-6 min-w-2xl bg-white rounded">
      <h1 className="font-bold">{film.title}</h1>
      
      <div className="flex gap-x-3 justify-between mt-4">
        <section className="flex-1">
          <h2 className="border-b py-2 mb-2 font-bold border-gray-300">Opening Crawl</h2>
          <pre className="font-light text-sm">{film.opening_crawl}</pre>
        </section>
        
        <section className="flex-1">
          <h2 className="border-b py-2 font-bold border-gray-300">Characters</h2>
          
          {renderCommaSeperatedLinks(film.characters)}
        </section>
      </div>
      
      <Link className="uppercase text-white bg-green-500 hover:bg-green-600 px-6 py-2 mt-2 rounded-4xl" href="/" as="button">Back to search</Link>
    </div>
  )
}
