class PresenceValidator
  attr_reader :attributes
  def initialize(attributes)
    @attributes = attributes
  end
  def call(object)
    attributes.each do |attribute|
      value = object.send(attribute)
      object.errors.add(attribute.to_s, "can't be blank") if value.nil?
    end
  end
end