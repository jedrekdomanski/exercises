require 'sinatra'
require 'json'

# class variables return warning: class variable access from toplevel. I used class methods instead

class Db
  def self.initialize
    @@cars = []
  end

  def self.create(car)
    @@cars << car
  end

  def self.find(id)
    @@cars.detect { |car| car.id == id }
  end

  def self.get_cars
    @@cars
  end
end

configure do
  Db.initialize
end

before do
  content_type 'application/json'
end

class Car
  attr_reader :id, :make, :name, :year

  def initialize(id:, make:, name:, year:)
    @id   = id
    @make = make
    @name = name
    @year = year
  end

  def to_h
    {
     id: id,
     make: make,
     name: name,
     year: year
    }
  end

  def to_json
    to_h.to_json
  end
end

get '/cars' do
  cars = Db.get_cars
  { cars: cars.map(&:to_h) }.to_json
end

get '/cars/:id' do
  car = Db.find(params[:id])
  car.to_json
end

post '/cars' do
  car = Car.new(id: params[:id],
                make: params[:make],
                name: params[:name],
                year: params[:year])
  Db.create(car)
  status 201
end



# Usage:
# ruby app.rb
# curl -d "id=1&make=Ford&name=Fiesta&year=2006" http://localhost:4567/cars
# curl http://localhost:4567/cars
# curl http://localhost:4567/cars/1
