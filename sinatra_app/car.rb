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