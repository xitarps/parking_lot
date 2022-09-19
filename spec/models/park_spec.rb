# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Park do
  describe 'should generate a reservation code' do
    context 'successfully' do
      it 'when call .generate_code' do
        expect(Park.new.generate_code).not_to be_empty
      end
    end
  end

  describe 'should attempt to generate an instance of Park' do
    context 'successfully' do
      it 'when correct plate format' do
        park = Park.new(plate: 'aaa-1234')
        expect(park).to be_valid
      end
    end
    context 'unsuccessfully' do
      it 'when wrong plate format' do
        park = Park.new(plate: 'aaa-123')
        expect(park).not_to be_valid
      end
    end
  end

  describe 'should build details hash from Park object' do
    let(:park) { Park.create!(plate: 'aaa-1234') }
    context 'successfully' do
      it 'when call .fetch_single_details' do
        single_details = park.fetch_single_details
        expectation = { time: park.send(:fetch_time), paid: park.paid,
                        left: park.left, plate: park.plate,
                        reservation: park.reservation }

        expect(single_details).to be_eql(expectation)
      end

      it 'when call .reservation_details' do
        reservation_details = park.fetch_reservation_details
        expectation = { reservation: park.reservation, plate: park.plate,
                        entered_at: park.created_at }

        expect(reservation_details).to be_eql(expectation)
      end

      it 'when call #history' do
        3.times { described_class.create!(plate: 'aaa-1234') }
        parks = described_class.where(plate: 'aaa-1234')
        history = described_class.history(parks)

        expect(history.count).to be_eql(3)
      end
    end
  end

  describe 'should get parking time' do
    context 'successfully' do
      it 'when call #fetch_time' do
        park = Park.create(plate: 'aaa-1234')
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
