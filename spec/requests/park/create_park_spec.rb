# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Create Park' do
  context 'when request' do
    context 'POST /parking' do
      it 'successfully' do
        plate = 'aaa-2345'
        body = { plate: }.to_json

        post '/parking', body

        expect(last_response.status).to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(json_parse['plate']).to eq(plate)
      end

      it 'unssuccessfully' do
        plate = 'aaa-235'
        body = { plate: }.to_json

        post '/parking', body

        expect(last_response.status).to eq(422)
        expect(last_response.status).not_to eq(200)
        expect(last_response.content_type).to eq('application/json')
        expect(json_parse['plate']).to be_nil
        expect(json_parse['errors']['plate']).to include('is invalid')
      end
    end
  end
end
