require './constant'

def assig_routes_to_drivers()

  Route.all().each do |route|
    #if the route isn't assign to a driver
    if(route.driver_id == DEFAULT_INDEX_UNASSIGNED)
      #available drivers
      drivers = Driver.where(
                      'id NOT IN (
                      SELECT driver_id
                      FROM assigned_routes
                      WHERE (starts_at BETWEEN ? AND ?)
                      OR (ends_at BETWEEN ? AND ?))',

      route.starts_at, route.ends_at, route.starts_at, route.ends_at)

      #assigned cities in the route
      cities_in_route = RouteCity.where(routes_id: route.id).pluck(:cities)

      #available vehicles by load type, not assigned and capacity over the route weight
      load_type_vehicles = Vehicle.where(load_type: route.load_type)
                                  .where(driver_id: 0)
                                  .where("capacity >= ?", route.load_sum)
      flag = false
      drivers.each do |driver|
        #cities restriction by the driver
        ban_cities = BannedCity.where(driver_id: driver.id).pluck(:cities)

        next if(!(ban_cities & cities_in_route).empty?)

        if(!flag)
          AssignedRoute.create(
            route_id: route.id,
            driver_id: driver.id,
            starts_at: route.starts_at,
            ends_at: route.ends_at
          )

          #update the db
          driver.update(vehicle_id: load_type_vehicles.first.id)
          route.update(vehicle_id: load_type_vehicles.first.id)
          route.update(driver_id: driver.id)
          flag = true
        end
      end
    end
  end
end

def print_routes()
  print "#{"ID".ljust(6)} #{"Vehículo".ljust(10)} #{"ID Conductor".ljust(15)} #{"ID Ruta".ljust(10)} #{"Hora inicio ruta".ljust(30)} #{"Hora fin ruta".ljust(30)}\n"
  AssignedRoute.all().each do |planification|
    route = Route.where(id: planification.route_id)
    print "#{route.first.id.to_s.ljust(6)} #{route.first.vehicle_id.to_s.ljust(10)} #{planification.driver_id.to_s.ljust(15)} #{planification.route_id.to_s.ljust(10)} #{planification.starts_at.to_s.ljust(30)} #{planification.ends_at.to_s.ljust(30)}\n"
  end
end
