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