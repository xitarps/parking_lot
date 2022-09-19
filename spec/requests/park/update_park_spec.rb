# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Update Park' do
  context 'when request' do
    let(:plate) { 'aaa-1234' }
    let!(:park) { Park.create(plate:) }
    context 'PUT /parking/:id/pay' do
      it 'successfully' do
        put "/parking/#{plate}/pay"

        expect(last_response.status).to eq(204)

        expect(last_response.body).to be_empty
      end

      it 'unsuccessfully' do
        wrong_plate = 'aaa-1111'
        put "/parking/#{wrong_plate}/pay"

        expect(last_response.status).to eq(404)

        expect(json_parse['errors']['plate']).to include('not found')
      end
    end

    context 'PUT /parking/:id/out' do
      it 'successfully' do
        put "/parking/#{plate}/pay"
        put "/parking/#{plate}/out"

        expect(last_response.status).to eq(204)

        expect(last_response.body).to be_empty
      end

      it 'unsuccessfully' do
        wrong_plate = 'aaa-1111'
        put "/parking/#{wrong_plate}/out"

        expect(last_response.status).to eq(404)

        expect(json_parse['errors']['plate']).to include('not found')
      end

      it 'unsuccessfully' do
        put "/parking/#{plate}/out"

        expect(last_response.status).to eq(422)

        expect(json_parse['errors']['plate']).to include('not paid')
      end
    end
  end
end
