class Error
  attr_reader :attribute, :message
  def initialize(attribute, message)
    @attribute = attribute
    @message = message
  end
end