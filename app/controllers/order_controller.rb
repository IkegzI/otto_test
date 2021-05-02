class OrderController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def destroy
  end

  def get_list

    list_json = OrderLine.joins(
        order: [:user]
    ).pluck(
        "orders.id",
        "order_lines.item_id",
        "order_lines.amount",
        "users.firstname",
        "users.lastname",
        "users.number"
    ).group_by{|arr| arr.first}.to_json

    render json: list_json

  end

end
