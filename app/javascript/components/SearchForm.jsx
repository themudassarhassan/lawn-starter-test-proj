import React from 'react'

export function SearchForm({ onSearch, data, setData, processing }) {
  const { resourceType, query } = data
  const placeholderText = resourceType === 'people' ? 'Search for people' : 'Search for movies';

  return (
    <form onSubmit={onSearch}>
      <h2 className=" mb-4">
        What are you searching for?
      </h2>
      <div className="flex gap-4 mb-4">
        <label className="flex items-center font-bold">
          <input
            type="radio"
            name="searchType"
            value="people"
            checked={resourceType === 'people'}
            onChange={(e) => setData('resourceType', e.target.value)}
            className="mr-2"
          />
          People
        </label>
        <label className="flex items-center font-bold">
          <input
            type="radio"
            name="searchType"
            value="films"
            checked={resourceType === 'films'}
            onChange={(e) => setData('resourceType', e.target.value)}
            className="mr-2"
          />
          Movies
        </label>
      </div>

      <input
        className="w-full border border-gray-300 p-2 rounded-md my-4 focus:outline-none focus:ring-2 focus:ring-gray-400"
        type="text"
        required
        value={query}
        placeholder={placeholderText}
        onChange={e => setData('query', e.target.value)}
      />

      <button
        className="w-full bg-green-500 text-white py-2 rounded-2xl text-lg font-semibold hover:bg-green-600 uppercase disabled:bg-gray-400"
        disabled={!query}
        type="submit"
      >
        {processing ? 'Searching...': 'Search'}
      </button>
    </form>
  )
}
