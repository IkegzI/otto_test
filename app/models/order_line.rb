class OrderLine < ApplicationRecord
  belongs_to :order

  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :amount, presence: true

  def self.save_lines_from_params(order_id, items)
    order_lines_new_array = []
    items.keys.each do |key|
      items[key][:order_id] = order_id
      items[key][:item_id] = items[key][:item_id].to_i
      order_line_new = OrderLine.new(items[key].as_json)
      raise 'check data' unless order_line_new.validate
      order_lines_new_array << order_line_new
    end
    order_lines_new_array.each(&:save!)
    true
  end

end
