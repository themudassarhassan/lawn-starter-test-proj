import React from 'react'

export function SearchForm({ onSearch, defaultQuery, defaultResourceType }) {
  const [searchQuery, setSearchQuery] = React.useState(defaultQuery || '')
  const [type, setType] = React.useState(defaultResourceType || 'people')
  
  const placeholderText = type === 'people' ? 'Search for people' : 'Search for movies';
  
  function handleSubmit(e) {
    e.preventDefault()
    
    onSearch({ type, searchQuery })
  }

  return (
    <form onSubmit={handleSubmit}>
      <h2 className=" mb-4">
        What are you searching for?
      </h2>
      <div className="flex gap-4 mb-4">
        <label className="flex items-center font-bold">
          <input
            type="radio"
            name="searchType"
            value="people"
            checked={type === 'people'}
            onChange={(e) => setType(e.target.value)}
            className="mr-2"
          />
          People
        </label>
        <label className="flex items-center font-bold">
          <input
            type="radio"
            name="searchType"
            value="films"
            checked={type === 'films'}
            onChange={(e) => setType(e.target.value)}
            className="mr-2"
          />
          Movies
        </label>
      </div>

      <input
        className="w-full border border-gray-300 p-2 rounded-md my-4 focus:outline-none focus:ring-2 focus:ring-gray-400"
        type="text"
        required
        value={searchQuery}
        placeholder={placeholderText}
        onChange={e => setSearchQuery(e.target.value)}
      />

      <button
        className="w-full bg-green-500 text-white py-2 rounded-2xl text-lg font-semibold hover:bg-green-600 uppercase disabled:bg-gray-400"
        disabled={!searchQuery}
        type="submit"
      >
        Search
      </button>
    </form>
  )
}
