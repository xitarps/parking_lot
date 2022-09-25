# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Park do
  describe 'when attempt to generate an instance of Park' do
    context 'call .generate_code' do
      it 'successfully' do
        expect(described_class.new.generate_code).not_to be_empty
      end
    end

    context 'with correct plate format' do
      it 'be valid ' do
        park = described_class.new(plate: 'aaa-1234')
        expect(park).to be_valid
      end
    end

    context 'with wrong plate format' do
      it 'not be valid' do
        park = described_class.new(plate: 'aaa-123')
        expect(park).not_to be_valid
      end
    end
  end

  describe 'return hash(es)' do
    let(:park) { described_class.create!(plate: 'aaa-1234') }
    context 'when call .fetch_single_details' do
      it 'successfully' do
        single_details = park.fetch_single_details
        expectation = { time: park.send(:fetch_time), paid: park.paid,
                        left: park.left, plate: park.plate,
                        reservation: park.reservation }

        expect(single_details).to be_eql(expectation)
      end
    end

    context 'when call .reservation_details' do
      it 'successfully' do
        reservation_details = park.fetch_reservation_details
        expectation = { reservation: park.reservation, plate: park.plate,
                        entered_at: park.created_at }

        expect(reservation_details).to be_eql(expectation)
      end
    end

    context 'when call #history' do
      it 'successfully display array of hashes' do
        3.times { described_class.create!(plate: 'aaa-1234') }
        parks = described_class.where(plate: 'aaa-1234')
        history = described_class.history(parks)

        expect(history.count).to be_eql(3)
      end
    end
  end

  describe 'get parking time' do
    context 'when call #fetch_time' do
      it 'successfully' do
        park = described_class.create(plate: 'aaa-1234')
        travel_to(20.seconds.from_now) do
          expect(park.send(:fetch_time)).to include('seconds')
        end
        travel_to(20.minutes.from_now) do
          expect(park.send(:fetch_time)).to include('minutes')
        end
        travel_to(20.hours.from_now) do
          expect(park.send(:fetch_time)).to include('hours')
        end
        travel_to(20.days.from_now) do
          expect(park.send(:fetch_time)).to include('days')
        end
      end
    end
  end
end
