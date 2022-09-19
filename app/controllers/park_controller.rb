# frozen_string_literal: true

# This controller handles Park actions requests
class ParkController < ApplicationController
  def show
    parks = Park.where(plate: params[:plate])
    build_response(Park.history(parks), 200)
  end

  def create
    parks = Park.where(plate: params[:plate])
    return build_response('already parked', 422) if parks.pluck(:left)
                                                         .any? false

    park = Park.new(parking_params)
    return build_response('is invalid', 422) unless park.valid?

    park.save!
    build_response(park.fetch_reservation_details, 200)
  end

  def update
    @last_park = Park.where(plate: params['id'])&.last

    return build_response('not found', 404) if @last_park.nil?

    return pay if options[:act] == 'pay'

    out if options[:act] == 'out'
  end

  private

  def parking_params
    { plate: params[:plate] }
  end

  def pay
    @last_park.update_attributes(paid: true).to_json
    build_response({}, 204)
  end

  def out
    return build_response('not paid', 422) unless @last_park.paid

    @last_park.update_attributes(left: true)
    build_response({}, 204)
  end
end
