class Product < ApplicationRecord
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [250, 250]
    attachable.variant :medium, resize_to_limit: [250, 250]
  end

  belongs_to :category
  has_many :stocks
  has_many :order_products
  has_many :orders, through: :order_products

  validates :name, :description, :price, :category_id, presence: true

  def total_sales
    order_products.sum(&:quantity)
  end
end
