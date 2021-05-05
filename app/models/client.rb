class Client < ApplicationRecord

  validates :number, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :post_index, presence: true

end
