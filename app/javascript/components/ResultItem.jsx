import { Link } from "@inertiajs/react"

export function ResultItem({ name, title, url }) {
  return (
    <li className="flex justify-between items-center border-b border-gray-300 py-3">
      <p>{name || title}</p>

      <Link href={url} className="bg-green-500 hover:bg-green-600 text-white rounded-lg px-2 py-2 uppercase">See details</Link>
    </li>
  )
}
