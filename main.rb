require './schema'
require './constant'
require './data'
require './scheduler'

load_data()

print "\n\n-- Drivers --\n\n"
print "#{"Id".ljust(6)} #{"Name".ljust(20)} #{"Phone".ljust(20)} #{"Mail".ljust(20)}\n\n"
Driver.all().each do |element|
  print "#{element.id.to_s.ljust(6)} #{element.name.gsub("\n", "").ljust(20)} #{element.phone.gsub("\n", "").ljust(20)} #{element.email.gsub("\n", "").ljust(20)}\n"
end

print "\n\n-- Routes --\n\n"
print "#{"Id".ljust(6)} #{"Starts at".ljust(30)} #{"Ends at".ljust(30)} #{"Load Type".ljust(20)}\n\n"
Route.all().each do |element|
  print "#{element.id.to_s.ljust(6)} #{element.starts_at.to_s.ljust(30)} #{element.ends_at.to_s.ljust(30)} #{element.load_type.gsub("\n", "").ljust(20)}\n"
end

print "\n\n-- Vehicles --\n\n"
print "#{"Id".ljust(6)} #{"Capacity".ljust(10)} #{"Load Type".ljust(20)}\n\n"
Vehicle.all().each do |element|
  print "#{element.id.to_s.ljust(6)} #{element.capacity.to_s.ljust(10)} #{element.load_type.gsub("\n", "").to_s.ljust(6)}\n"
end

print "\n\n-- Planning --\n\n"
assig_routes_to_drivers()
print_routes()
