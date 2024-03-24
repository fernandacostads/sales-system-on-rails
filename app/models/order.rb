class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products, allow_destroy: true
  validates :customer_email, presence: true

  # def calculate_subtotal
  #   order_products.sum { |op| op.product.price * op.quantity } # itera sobre os itens do pedido e soma os preços de cada produto multiplicado pela quantidade
  # end

    def calculate_subtotal
      subtotal = order_products.sum { |op| op.product.price * op.quantity }
      puts "Subtotal calculado: #{subtotal}" # Adicione esta linha para verificar o subtotal calculado
      subtotal
    end
  

  def calculate_delivery_fee
    30
  end

  def calculate_discount
    calculate_total_order > 100 ? (calculate_total_order * 0.1) : 0  #10% acima de 100R$
  end

  def self.orders_containing_product(product_id)
    joins(:order_products).where(order_products: { product_id: product_id }).distinct
  end

  def calculate_total_order
    calculate_subtotal = calculate_subtotal || 0
    calculate_delivery_fee = calculate_delivery_fee || 0
    calculate_discount = calculate_discount || 0
    
    calculate_subtotal + calculate_delivery_fee - calculate_discount
  end


end
