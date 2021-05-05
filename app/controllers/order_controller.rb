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
    client_info = params.permit(:firstname, :lastname, :post_index, :number, :ignore)
    order_lines = params.require(:items) if params[:items].present?
    unless order_lines
      render json: {error: 'Add line and items'}.to_json
      return
    end
    item_ids = order_lines.keys.map { |key| order_lines[key][:item_id].to_i }
    amounts = order_lines.keys.map { |key| order_lines[key][:amount].to_i }


    unless client_info[:ignore] == 'true'
      if Order.dublicate?(item_ids, amounts)
        render json: {error: 'dublicate'}.to_json
        return
      end
    end
    client = Client.find_by(
        number: client_info[:number].to_i
    )
    if client
      order_save = Order.correct_info?(client, client_info)
      render json: {error: 'check user data'}.to_json, status: 200 unless order_save
      return
    else
      client = Client.new(client_info)
    end
    order_line_save = ''
    client_save = ''
    order_save = ''
    Order.transaction do
      client_save = client.save unless client.id
      order = Order.new(client: client)
      order_save = order.save
      order_line_save = OrderLine.save_lines_from_params(order.id, order_lines)
    end
    unless order_save or order_line_save or client_save
      render json: {error: 'Check data order'}.to_json, status: 200
      return
    end
    # binding.pry
    respond_to do |format|
      format.html { render html: 'ok' }
      format.json { render json: {error: 'no_error'} }
    end
  end

end
