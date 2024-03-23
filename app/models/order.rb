class Order < ApplicationRecord
  has_many :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true
  validates :customer_email, presence: true
end
