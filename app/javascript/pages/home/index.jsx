import React from 'react'
import { useForm } from '@inertiajs/react'
import { ResultItem, NotFoundMessage, CenterContainer, SearchForm } from '../../components'

export default function Index({ results, query, resource_type }) {
  const { data, setData, get, processing } = useForm({
    query: query || '',
    resourceType: resource_type || 'people'
  })

  const isFound = results.length !== 0

  function handleSearch(e) {
    e.preventDefault()

    get('/')
  }

  return (
    <div className="flex flex-col items-start md:flex-row justify-center mt-10 gap-6">
      <section className="w-full md:w-96 flex-shrink-0 bg-white rounded-lg shadow-md p-6">
        <SearchForm onSearch={handleSearch} data={data} setData={setData} />
      </section>

      <section className="w-full md:w-[600px] min-h-[600px] bg-white rounded-lg shadow-md p-6">
        <h2 className="text-lg font-medium mb-4 border-b border-gray-300 py-2">Results</h2>

        {processing ? (
          <CenterContainer>
            <p>Searching...</p>
          </CenterContainer>
        ): isFound ? results.map(r => <ResultItem key={r.url} {...r} />) : (
          <CenterContainer>
            <NotFoundMessage />
          </CenterContainer>
        )}
      </section>
    </div>
  )
}
