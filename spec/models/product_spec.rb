require "rails_helper"

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "is valid with valid attributes" do
      @category = Category.new(name: "Food")
      @category.save
      @product = @category.products.create!(name: "coconut", price: 50, quantity: 99, category: @category)
      @product.save
      expect(@product).to be_valid
    end

    it "is not valid without a category" do
      product = Product.new(name: "coke", price: 50, quantity: 99, category: nil)
      expect(product).to_not be_valid
    end

    it "is not valid without a price" do
      product = Product.new(name: "peanuts", price: nil, quantity: 100, category: @category)
      expect(product).to_not be_valid
    end

    it "is not valid without a name" do
      product = Product.new(name: nil, price: 99, quantity: 100, category: @category)
      expect(product).to_not be_valid
    end

    it "is not valid without a quantity" do
      product = Product.new(name: "dank", price: 99, quantity: nil, category: @category)
      expect(product).to_not be_valid
    end
  end
end