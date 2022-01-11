require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations Product' do
    # validation tests/examples here
    it 'should create a valid product for new records' do
      @product = Product.new
      expect(@product.id).to be_nil
    end

    it 'should save new product in the db' do
      @category = Category.create({name: "Spec"})
      
      @product = Product.new({
        name: "Test Kit",
        price_cents: 399,
        quantity: 4,
        category: @category
      })
      @product.save!
  
      expect(@product.id).to be_present

      expect(@product.name).to eq("Test Kit")
      expect(@product.price_cents).to eq(399)
      expect(@product.quantity).to eq(4)
      expect(@product.category).to eq(@category)
    end

    it 'validates error for blank name' do
      @category = Category.create({name: "Spec"})
      
      @product = Product.new({
        price_cents: 420,
        quantity: 69,
        category: @category
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages ).to eq(["Name can't be blank"])
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      
    end

    it 'validates error for blank price_cents' do
      @category = Category.create({name: "Spec"})
      
      @product = Product.new({
        name: "Test Kit",
        quantity: 4,
        category: @category
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages ).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      
    end

    it 'validates error for blank quantity' do
      @category = Category.create({name: "Spec"})
      
      @product = Product.new({
        name: "Test Kit",
        price_cents: 399,
        category: @category
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages ).to eq(["Quantity can't be blank"])
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      
    end

    it 'validates error for blank category' do
      @product = Product.new({
        name: "Test Kit",
        price_cents: 399,
        quantity: 4
      })
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages ).to eq(["Category can't be blank"])
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      
    end
  end
end
