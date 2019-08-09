#!/usr/bin/env ruby -wKU

require './schema'
require './constant'
require './data'

load_data()

puts "-- Drivers --"
Driver.all().each do |element|
  print "#{element.id}: nombre: #{element.name} #{element.phone} #{element.email}\n"
end

puts "-- Banned Cities --"
BannedCity.all().each do |element|
  puts "#{element.id}: driver: #{element.driver_id} ciudad: #{element.cities}"
end

puts "-- Routes --"
Route.all().each do |element|
  puts "#{element.id}: [#{element.starts_at} - #{element.ends_at}] #{element.load_type}"
end

puts "-- Route Cities --"
RouteCity .all().each do |element|
  puts "#{element.id}: #{element.routes_id} #{element.cities}"
end

puts "-- Vehicles --"
Vehicle.all().each do |element|
  puts "#{element.id}: #{element.capacity} #{element.load_type}"
end
