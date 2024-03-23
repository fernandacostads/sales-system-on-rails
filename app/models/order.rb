class Order < ApplicationRecord
  has_many :order_products
  
  validates :customer_email, presence: true
end
