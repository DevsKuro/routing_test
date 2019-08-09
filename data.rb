require './constant'

def cities_insertion()
  TOWN.each do |cities|
    City.create(name: cities)
  end
end

def drivers_insertion()
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

def routes_insertion()
  file='routes.txt'
  f = File.open(file, "r")
  route_data = Array.new
  id_counter = 0

  f.each_line { |line|
    if(!line.include? DATA_SEPARATOR)
      route_data << line
    else
      if(route_data.length >= MIN_DATA_ROUTES)
        #Add new route data
        Route.create(
          starts_at: route_data[0],
          ends_at: route_data[1],
          load_type: route_data[2],
          load_sum: route_data[3],
          stops_amount: route_data[4],
          vehicle_id: route_data[5],
          driver_id: route_data[6]
        )

        stops = route_data[4].to_i
        stops_counter = 0
        while (stops_counter < stops)
          RouteCity.create(
            routes_id: Route.maximum(:id),
            cities: route_data[stops_counter + 7]
          )
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

def vehicles_insertion()
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
  cities_insertion()
  drivers_insertion()
  routes_insertion()
  vehicles_insertion()
end
