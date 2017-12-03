require_relative 'error'
require_relative 'errors'
require_relative 'presence_validator'

class MyOwnActiveRecord
  attr_reader :errors

  @@validators = []
  def self.validators
    @@validators
  end

  def initialize
    @errors = Errors.new
  end

  def save(validates: true)
    return true if !validates

    validate!
    errors.size == 0
  end

  def validate!
    self.class.validators.each do |validator|
      validator.call(self)
    end
  end

  def self.validates(*attributes)
    raise ArgumentError, "You need to supply at least one attribute" if attributes.empty?
    validator_class = self.extract_validator_class!(attributes)
    @@validators.push(validator_class.new(attributes))
  end

  private

  def self.extract_validator_class!(attributes)
    validator_param = attributes.pop
    validator_type = validator_param.keys.first.to_s
    validator_class_name = "#{validator_type.capitalize}Validator"
    Object.const_get(validator_class_name)
  end
end
