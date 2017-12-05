class LengthValidator
  attr_reader :attributes
  def initialize(attributes)
    @attributes = attributes
  end
  def call(object)
    allowed_length = attributes.last[:length].values.first
    attributes[0..-2].each do |attribute|
      value = object.send(attribute)
      object.errors.add(attribute.to_s, "is the wrong length (should be #{allowed_length}) characters") unless value.to_s.length == allowed_length
    end
  end
end
