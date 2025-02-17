  require 'rails_helper'

RSpec.describe SwapiSearcher do
  let(:valid_type) { 'people' }
  let(:valid_query) { 'skywalker' }
  let(:searcher) { described_class.new(type: valid_type, query: valid_query) }

  describe '#initialize' do
    context 'with valid parameters' do
      it 'initializes successfully' do
        expect { searcher }.not_to raise_error
      end

      it 'normalizes the type parameter' do
        searcher = described_class.new(type: 'PEOPLE', query: valid_query)
        expect(searcher.type).to eq('people')
      end

      it 'trims the query parameter' do
        searcher = described_class.new(type: valid_type, query: ' skywalker ')
        expect(searcher.query).to eq('skywalker')
      end
    end

    context 'with invalid parameters' do
      it 'raises ArgumentError for invalid type' do
        expect {
          described_class.new(type: 'planets', query: valid_query)
        }.to raise_error(ArgumentError, /Invalid search type/)
      end
    end
  end

  describe '#call' do
    context 'with empty query' do
      let(:empty_query_searcher) { described_class.new(type: valid_type, query: '') }

      it 'returns an empty array' do
        expect(empty_query_searcher.call).to eq([])
      end

      it 'does not call the API' do
        expect(SwapiService).not_to receive(:get_all)
        empty_query_searcher.call
      end
    end

    context 'with valid query' do
      let(:mock_results) do
        {
          "count" => 1,
          "results" => [
            { "name" => "Luke Skywalker", "url" => "https://swapi.py4e.com/api/people/1/" }
          ]
        }
      end

      before do
        allow(SwapiService).to receive(:get_all).and_return(mock_results)
        allow(searcher).to receive(:person_path).with("1").and_return("/people/1")
      end

      it 'fetches results from SwapiService' do
        expect(SwapiService).to receive(:get_all).with(valid_type, search_query: valid_query)
        searcher.call
      end

      it 'parses the results correctly' do
        results = searcher.call
        expect(results).to be_an(Array)
        expect(results.first).to include(
          name: "Luke Skywalker",
          url: "/people/1"
        )
      end
    end

    context 'when searching for films' do
      let(:film_searcher) { described_class.new(type: 'films', query: 'hope') }
      let(:mock_film_results) do
        {
          "count" => 1,
          "results" => [
            { "title" => "A New Hope", "url" => "https://swapi.py4e.com/api/films/1/" }
          ]
        }
      end

      before do
        allow(SwapiService).to receive(:get_all).and_return(mock_film_results)
        allow(film_searcher).to receive(:film_path).with("1").and_return("/films/1")
      end

      it 'parses film results correctly' do
        results = film_searcher.call
        expect(results.first).to include(
          title: "A New Hope",
          url: "/films/1"
        )
      end
    end

    context 'with nil or invalid response' do
      before do
        allow(SwapiService).to receive(:get_all).and_return(nil)
      end

      it 'handles nil response gracefully' do
        expect(searcher.call).to eq([])
      end

      it 'handles response without results gracefully' do
        allow(SwapiService).to receive(:get_all).and_return({})
        expect(searcher.call).to eq([])
      end
    end
  end

  describe '#generate_url' do
    let(:people_searcher) { described_class.new(type: 'people', query: 'skywalker') }
    let(:films_searcher) { described_class.new(type: 'films', query: 'hope') }

    before do
      allow(people_searcher).to receive(:person_path).with("1").and_return("/people/1")
      allow(films_searcher).to receive(:film_path).with("1").and_return("/films/1")
    end

    it 'generates correct URL for people' do
      result = people_searcher.send(:generate_url, "https://swapi.py4e.com/api/people/1/")
      expect(result).to eq("/people/1")
    end

    it 'generates correct URL for films' do
      result = films_searcher.send(:generate_url, "https://swapi.py4e.com/api/films/1/")
      expect(result).to eq("/films/1")
    end
  end
end
