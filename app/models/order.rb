class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { wait_payment: 0, confirm_payment: 1, making: 2, preparing_delivery: 3, delivered: 4 }
  
  belongs_to :customer
  has_many :order_details, dependent: :destroy
end
