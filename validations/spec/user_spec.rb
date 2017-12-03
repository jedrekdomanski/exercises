require 'rspec'
require_relative '../lib/my_own_active_record'

class User < MyOwnActiveRecord
  attr_accessor :email, :phone
  def initialize(attributes = {})
    super()
    @email = attributes[:email]
    @phone = attributes[:phone]
  end

  validates :email, :phone, presence: true
end


describe "Validation" do
  context "Invalid user" do
    let(:user) { User.new }
   
    it "is not valid without email or phone number" do
      expect(user.save).to eq(false)
    end

    it "returns the correct errors messages" do
      user.save
      expect(user.errors.full_messages).to eq(["Email can't be blank", "Phone can't be blank"])
    end
  end

  context "Valid user" do
    let(:user) { User.new(email: "test@test123.com", phone: 123456789) }
   
    it "is valid with email or phone number " do
      expect(user.save).to eq(true)
    end

    it "returns an empty list of errors" do
      user.save
      expect(user.errors.full_messages).to eq([])
    end
  end
end
