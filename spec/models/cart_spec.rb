require 'rails_helper'
RSpec.describe Cart, type: :model do
  session_input = {
    "1" => 3,
    "2" => 1,
    "3" => 5
  }
  cart = Cart.new(session_input)

  it "should have a contents hash upon creation" do
    empty_cart = Cart.new({})
    expect(empty_cart.contents).to be_truthy
  end
end
