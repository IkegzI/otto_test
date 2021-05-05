class Order < ApplicationRecord
  belongs_to :client
  has_many :order_lines

  validates :client_id, presence: true


  def self.dublicate?(item_ids, amounts)
    begin
      order_find = OrderLine.where(
          item_id: item_ids,
          amount: amounts
      ).group(:order_id).having("count(order_id) = #{item_ids.size}")
      date_order_if = order_find.pluck(:updated_at).map{|date_updated| date_updated.to_date >=  (Date.today - 7.days)}
      return true if order_find.present? or (date_order_if.include? true)
    rescue
      false
    end
  end


  def self.correct_info?(client_find = '', client_info)
    client_find.attributes.select { |key| ['firstname', 'lastname'].include? key }.values == client_info.permit(:firstname, :lastname).values
  end
end
