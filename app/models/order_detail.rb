class OrderDetail < ApplicationRecord
  enum making_status: { imppossible_making: 0, wait_making: 1, making: 2, finish: 3 }
end
