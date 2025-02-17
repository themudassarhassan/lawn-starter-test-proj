import { Link } from "@inertiajs/react"

export default function Index({ message }) {
  return (
    <div className="shadow-md mt-3 px-6 py-6 min-w-2xl bg-white rounded">
      <p>
        {message}
      </p>
      
      <Link className="uppercase bottom-5 text-white bg-green-500 hover:bg-green-600 px-6 py-2 mt-2 rounded-4xl" href="/" as="button">Back to search</Link>
    </div>
  )
}
