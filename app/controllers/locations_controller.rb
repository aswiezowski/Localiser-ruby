require "base64"

class LocationsController < ApplicationController

  def new
  end

  def create
    @location = Location.new(params.require(:location).permit(:latitude, :longitude, :description))
    rand_bytes = Random.new.bytes(6)
    @location.code =  Base64.urlsafe_encode64(rand_bytes)
    if @location.save
      render json: location_to_json(@location)
    else
      render json: @location.errors, status: :bad_request
    end

  end

  def show
    location = Location.find_by!(code: params[:id])
    render json: location_to_json(location)
  end

  def update
    @location = Location.find_by!(code: params[:id])

    if @location.update(params.permit(:latitude, :longitude, :description))
      render json: location_to_json(@location)
    else
      render json: {"status"=> "Can't update article"}
    end
  end

  def destroy
    @location = Location.find_by!(code: params[:id])
    @location.destroy

    render json: {'status' => 'Location deleted'}
  end

  def shortest_route
    locations = Location.where(code: params[:codes])

    traveling_salesman_solver = TravelingSalesmanSolver.new
    render json: traveling_salesman_solver.findShortestPath(locations[0], locations)
  end

  private

  def location_to_json(location)
    { "code" => location.code, "latitude" => location.latitude, "longitude" => location.longitude, "description" => location.description}
  end
end
