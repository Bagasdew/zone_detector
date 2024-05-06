require 'rgeo'
class ApplicationController < ActionController::Base


  def check_restricted_area
    #test for triangle
    restricted_area_points = [
      [-74.0060, 40.7128],
      [-73.9968, 40.7034],
      [-74.0093, 40.7068],
    ]

    factory = RGeo::Geos.factory
    linear_ring = factory.create_linear_ring(restricted_area_points)
    restricted_area = factory.create_polygon(linear_ring)

    point_to_check_lon = params[:longitude]
    point_to_check_lat = params[:latitude]
    check_point = factory.point(point_to_check_lon, point_to_check_lat)
    within_restricted_area = restricted_area.contains?(check_point)

    if within_restricted_area
      puts "The point (#{point_to_check_lon}, #{point_to_check_lat}) is within the restricted area."
    else
      puts "The point (#{point_to_check_lon}, #{point_to_check_lat}) is outside the restricted area."
    end
  end
end
