require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid with valid attributes" do
      category = Category.new(name: 'TestCategory',
                              created_at: DateTime.now,
                              updated_at: DateTime.now)
      product = Product.new(name: 'SomeName',
                            price: 20,
                            quantity: 5,
                            category: category)
                            
      expect(product).to be_valid
    end

    it "is unvalid without price" do
      category = Category.new(name: 'TestCategory',
                              created_at: DateTime.now,
                              updated_at: DateTime.now)
      product = Product.new(name: 'SomeName',
                            price: nil,
                            quantity: 5,
                            category: category)

      expect(product).to_not be_valid
    end

    it "is unvalid without name" do
      category = Category.new(name: 'TestCategory',
                              created_at: DateTime.now,
                              updated_at: DateTime.now)
      product = Product.new(name: nil,
                            price: 20,
                            quantity: 5,
                            category: category)

      expect(product).to_not be_valid
    end

    it "is unvalid without quantity" do
      category = Category.new(name: 'TestCategory',
                              created_at: DateTime.now,
                              updated_at: DateTime.now)
      product = Product.new(name: 'SomeName',
                            price: nil,
                            quantity: nil,
                            category: category)

      expect(product).to_not be_valid
    end

    it "is unvalid without category" do
      category = Category.new(name: 'TestCategory',
                              created_at: DateTime.now,
                              updated_at: DateTime.now)
      product = Product.new(name: 'SomeName',
                            price: 20,
                            quantity: 5,
                            category: nil)
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
      expect(product).to_not be_valid
    end

  end
end
