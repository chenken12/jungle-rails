require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should not exist for new records' do
      @product = Product.new
      expect(@product.id).to be_nil
    end

    it 'should save new product in the db' do
      @category = Category.new({
        name: "Spec"
      })
      @category.save!
      
      @product = Product.new({
        name: "Test Kit",
        price_cents: 399,
        quantity: 4,
        category: @category
      })
      # we use bang here b/c we want our spec to fail if save fails (due to validations)
      # we are not testing for successful save so we have to assume it will be successful
      @product.save!
  
      expect(@product.id).to be_present

      expect(@product.name).to be_present
      expect(@product.price_cents).to be_present
      expect(@product.quantity).to be_present
      expect(@product.category).to be_present
    end
  end
end
