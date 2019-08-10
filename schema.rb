require 'sqlite3'
require 'active_record'

#Support db on memory
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

#Defining the db model
ActiveRecord::Schema.define do
    create_table :routes, force: true do |table|
      table.datetime :starts_at
      table.datetime :ends_at
      table.string :load_type
      table.integer :load_sum
      table.integer :stops_amount
      table.integer :vehicle_id
      table.integer :driver_id
    end

    create_table :vehicles, force: true do |table|
        table.integer :capacity
        table.string :load_type
        table.integer :driver_id
    end

    create_table :drivers, force: true do |table|
        table.string :name
        table.string :phone
        table.string :email
        table.integer :vehicle_id
      end

      create_table :cities, force: true do |table|
        table.string :name
      end

      create_table :route_cities, force: true do |table|
        table.string :cities
        table.references :routes
      end

      create_table :banned_cities, force: true do |table|
        table.string :cities
        table.references :driver
      end

      create_table :assigned_routes, force: true do |table|
        table.references :route
        table.references :driver
        table.datetime :starts_at
        table.datetime :ends_at
      end

end

#Defining active record model
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Route < ApplicationRecord
end

class City < ApplicationRecord
end

class RouteCity < ApplicationRecord
  belongs_to :routes
end

class Driver < ApplicationRecord
  has_one :vehicle
  has_many :driver_banned_cities
end

class BannedCity < ApplicationRecord
  belongs_to :driver
  belongs_to :city
end

class Vehicle < ApplicationRecord
  belongs_to :driver
end

class AssignedRoute < ApplicationRecord
  belongs_to :route
  belongs_to :driver
end
