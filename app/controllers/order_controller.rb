class OrderController < ApplicationController
  def index
  end

  def new
  end

  def destroy
  end

  def index

    list_json = OrderLine.joins(
        order: [:client]
    ).pluck(
        "orders.id",
        "order_lines.item_id",
        "order_lines.amount",
        "clients.firstname",
        "clients.lastname",
        "clients.number"
    ).group_by { |arr| arr.first }.to_json
    respond_to do |format|
      format.html
      format.json { render json: list_json }
    end

  end

  def create
    client_info = params.permit(:firstname, :lastname, :post_index, :number)
    order_lines = params.require(:items)
    item_ids = order_lines.keys.each { |key| order_lines[key][:item_id].to_i }
    amounts = []
    order_lines.keys.each { |key| amounts << order_lines[key][:amount].to_i }
    if Order.dublicate?(item_ids, amounts)
      render json: {error: 'dublicate'}.to_json
      return
    end
    client = Client.find_by(
        number: client_info[:number].to_i
    )
    if client
      order_save = Order.correct_info?(client, client_info)
      render json: {error: 'check user data'}.to_json unless order_save
      return
    else
      client = Client.new(client_info)
    end
    order_line_save = ''
    client_save = ''
    Order.transaction do
      client_save = client.save unless client.id
      order = Order.new(client: client)
      order_save = order.save
      order_line_save = OrderLine.save_lines_from_params(order.id, order_lines)
    end
    render json: {error: 'Check data order'}.to_json unless order_save or order_line_save or client_save
  end

end
