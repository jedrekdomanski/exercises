require 'rspec'
require 'byebug'
require_relative '../lib/my_own_active_record'

class User < MyOwnActiveRecord
  attr_accessor :email, :phone
  def initialize(attributes = {})
    super()
    @email = attributes[:email]
    @phone = attributes[:phone]
  end

  validates :email, :phone, presence: true
  validates :phone, length: { is: 9 }
end

describe "Validation" do
  context "Invalid user" do
    let(:user) { User.new }
   
    it "is not valid without email or phone number" do
      expect(user.save).to eq(false)
    end

    it "returns the correct error messages when attributes are not given" do
      user.save
      expect(user.errors.full_messages).to eq(
        ["Email can't be blank",
         "Phone can't be blank",
         "Phone is the wrong length (should be 9) characters"
        ])
    end

    it "returns the correct error messages when phone number is not the right length" do
      user = User.new(email: "test@tes.com", phone: 12345)
      user.save
      expect(user.errors.full_messages).to eq(["Phone is the wrong length (should be 9) characters"])
    end
  end

  context "Valid user" do
    let(:user) { User.new(email: "abc@1.com", phone: 123456789) }
   
    it "is valid with email or phone number" do
      expect(user.save).to eq(true)
    end

    it "returns an empty list of errors" do
      user.save
      expect(user.errors.full_messages).to eq([])
    end
  end
end
