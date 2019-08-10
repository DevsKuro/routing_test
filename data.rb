require './constant'

def load_cities()
  TOWN.each do |cities|
    City.create(name: cities)
  end
end

def load_drivers()
  file='drivers.txt'
  f = File.open(file, "r")
  driver_data = Array.new
  id_counter = 0

  f.each_line { |line|
    if(!line.include? DATA_SEPARATOR)
      driver_data << line
    else
      if(driver_data.length >= MIN_DATA_DRIVERS)

        #Add new driver data
        Driver.create(
          name: driver_data[0],
          phone: driver_data[1],
          email: driver_data[2],
          vehicle_id: driver_data[3],
        )

        #Add banned cities
        cities_counter = 4
        while cities_counter < driver_data.length
          BannedCity.create(cities: driver_data[cities_counter],
                            driver_id: Driver.maximum(:id))
          cities_counter += 1
        end

        id_counter += 1;
        driver_data.clear
      else
        if(id_counter != 0)
          puts "Invalid data insertion"
        end
      end
    end
  }
  f.close
end

def load_routes()
  file='routes.txt'
  f = File.open(file, "r")
  route_data = Array.new
  id_counter = 0

  f.each_line { |line|
    if(!line.include? DATA_SEPARATOR)
      route_data << line
    else
      if(route_data.length >= MIN_DATA_ROUTES)

        if(route_data[5] == "\n" || route_data[5] == " " )
          route_data[5] = "DEFAULT_INDEX_UNASSIGNED"
        end

        if(route_data[6] == "\n" || route_data[6] == " " )
          route_data[6] = "DEFAULT_INDEX_UNASSIGNED"
        end

        #Add new route data
        Route.create(
          starts_at: route_data[0],
          ends_at: route_data[1],
          load_type: route_data[2],
          load_sum: route_data[3],
          stops_amount: route_data[4],
          vehicle_id: DEFAULT_INDEX_UNASSIGNED,
          driver_id: DEFAULT_INDEX_UNASSIGNED
        )

        stops = route_data[4].to_i
        stops_counter = 0
        while (stops_counter < stops)
          if (route_data.length > (stops_counter + MIN_DATA_ROUTES-1))
            RouteCity.create(
              routes_id: Route.maximum(:id),
              cities: route_data[stops_counter + MIN_DATA_ROUTES-1]
            )
          end
          stops_counter += 1
        end

        route_data.clear
        id_counter += 1
      else
        if(id_counter != 0)
          puts "Invalid data insertion"
        end
      end
    end
  }
  f.close
end

def load_vehicles()
  file='vehicles.txt'
  f = File.open(file, "r")
  route_data = Array.new
  id_counter = 0

  f.each_line { |line|
    if(!line.include? DATA_SEPARATOR)
      route_data << line
    else
      if(route_data.length >= MIN_DATA_VEHICLES)
        #Add new vehicles data

        if(route_data[2] == "\n" || route_data[2] == " " )
          route_data[2] = "DEFAULT_INDEX_UNASSIGNED"
        end

        Vehicle.create(
            capacity: route_data[0],
            load_type: route_data[1],
            driver_id: route_data[2],
        )

        route_data.clear
        id_counter += 1
      else
        if(id_counter != 0)
          puts "Invalid data insertion"
        end
      end
    end
  }
  f.close
end

def load_data()
  load_cities()
  load_drivers()
  load_routes()
  load_vehicles()
end
