import React from 'react'
import { router } from '@inertiajs/react'
import { ResultItem, NoResultsFound, SearchForm } from '../../components'

export default function Index({ results, query, resource_type }) {
  const isFound = results.length !== 0

  function handleSearch({ type, searchQuery }) {
    router.get('/', { search_query: searchQuery, type })
  }

  return (
    <div className="flex flex-col items-start md:flex-row justify-center mt-10 gap-6">
      <section className="w-full md:w-96 flex-shrink-0 bg-white rounded-lg shadow-md p-6">
        <SearchForm onSearch={handleSearch} defaultQuery={query} defaultResourceType={resource_type} />
      </section>

      <section className="w-full md:w-[600px] min-h-[600px] bg-white rounded-lg shadow-md p-6">
        <h2 className="text-lg font-medium mb-4 border-b border-gray-300 py-2">Results</h2>

        {isFound ? results.map(r => <ResultItem {...r} />) : <NoResultsFound />}
      </section>
    </div>
  )
}
