require 'rails_helper'
require 'webmock/rspec'

RSpec.describe SwapiService do
  let(:base_url) { "https://swapi.py4e.com/api" }

  before do
    allow(Rails.cache).to receive(:fetch).and_yield
  end

  describe '.get_all' do
    context 'with valid resource type' do
      let(:people_url) { "#{base_url}/people/?search=skywalker" }
      let(:people_response) do
        {
          'count' => 1,
          'results' => [ { 'name' => 'Luke Skywalker' } ]
        }
      end

      before do
        stub_request(:get, people_url)
          .to_return(status: 200, body: people_response.to_json)
      end

      it 'returns search results' do
        result = described_class.get_all('people', search_query: 'skywalker')
        expect(result).to eq(people_response)
      end
    end

    context 'with invalid resource type' do
      it 'raises UnknownResourceType error' do
        expect {
          described_class.get_all('invalid_type')
        }.to raise_error(SwapiService::UnknownResourceType)
      end
    end
  end

  describe '.get_person' do
    let(:person_id) { 1 }
    let(:person_url) { "#{base_url}/people/#{person_id}/" }
    let(:person_response) { { 'name' => 'Luke Skywalker' } }

    before do
      stub_request(:get, person_url)
        .to_return(status: 200, body: person_response.to_json)
    end

    it 'fetches a person by id' do
      result = described_class.get_person(person_id)
      expect(result).to eq(person_response)
    end

    it 'uses the cache' do
      expect(Rails.cache).to receive(:fetch).with("person_#{person_id}", anything)
      described_class.get_person(person_id)
    end
  end

  describe '.get_film' do
    let(:film_id) { 1 }
    let(:film_url) { "#{base_url}/films/#{film_id}/" }
    let(:film_response) { { 'title' => 'A New Hope' } }

    before do
      stub_request(:get, film_url)
        .to_return(status: 200, body: film_response.to_json)
    end

    it 'fetches a film by id' do
      result = described_class.get_film(film_id)
      expect(result).to eq(film_response)
    end

    it 'uses the cache' do
      expect(Rails.cache).to receive(:fetch).with("film_#{film_id}", anything)
      described_class.get_film(film_id)
    end
  end
end
