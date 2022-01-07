class Admin::DashboardController < ApplicationController
  def show
    @category = Category.all
    @category_count = []

    @category.each do |cat|
      @product_by_category = Product.where(category_id: cat.id).count

      @category_count.push({
        name: cat.name,
        count: @product_by_category
      })
    end

    @category_count.push({
      name: "Total",
      count: Product.count
    })
  end
end
