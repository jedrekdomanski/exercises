class Errors
  def initialize
    @errors = []
  end

  def add(attribute, message)
    @errors.push(Error.new(attribute, message))
  end

  def full_messages
    @errors.map do |error|
      "#{error.attribute.capitalize} #{error.message}"
    end
  end

  def size
    @errors.size
  end
end