# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Show Park' do
  context 'when request' do
    context 'GET /parking/:id' do
      let(:plate) { 'aaa-2345' }
      it 'successfully' do
        post '/parking', { plate: }.to_json

        get "/parking/#{plate}"

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')

        result = json_parse.map { |object| object['reservation'] }
        expect(result).not_to be_nil
        expect(result.count).to be_eql(1)
      end

      it 'unsuccessfully' do
        post '/parking', { plate: }.to_json

        get '/parking/invalid-plate'

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')

        result = json_parse.map { |object| object['reservation'] }
        expect(result).to be_empty
        expect(result.count).to be_zero
      end
    end
  end
end
