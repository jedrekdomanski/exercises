require 'sinatra'
require 'json'
require_relative 'db'
require_relative 'car'

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
