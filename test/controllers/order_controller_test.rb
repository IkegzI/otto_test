require 'test_helper'

class OrderControllerTest < ActionDispatch::IntegrationTest
  def setup
    Rails.application.load_seed
  end

  # test "should get index" do
  #   get order_index_url
  #   assert_response :success
  # end

  test "should get index" do
    get '/order.json'
    json_answer = begin
                    JSON.parse(response.body)
                    :success
                  rescue
                    false
                  end
    assert_response json_answer
  end

  test "should new" do
    post '/order', {params: {number: 1, firstname: 'as', lastname: 'as', post_index: 664000,
                                 items: {
                                     '1' => {
                                         item_id: '1',
                                         amount: '1'
                                     },
                                     '2' => {
                                         item_id: '2',
                                         amount: '2'
                                     }
                                 }}
    }
    assert_equal("ok", response.body)
  end

  test "should new order dublicate" do
    order = Order.last

    order_attr = {number: order.client.number, firstname: order.client.firstname, lastname: order.client.lastname, post_index: order.client.post_index}
    order_attr[:items] ||= {}

    order.order_lines.each_with_index do |line, index|
      order_attr[:items][index] ||= {}
      order_attr[:items][index][:item_id] ||= line.item_id
      order_attr[:items][index][:amount]||= line.amount
    end

    post '/order', {params: order_attr}
    assert_equal("{\"error\":\"dublicate\"}", response.body)
  end

  test "should new order force dublicate" do
    order = Order.last

    order_attr = {number: order.client.number, firstname: order.client.firstname, lastname: order.client.lastname, post_index: order.client.post_index, ignore: true}
    order_attr[:items] ||= {}

    order.order_lines.each_with_index do |line, index|
      order_attr[:items][index] ||= {}
      order_attr[:items][index][:item_id] ||= line.item_id
      order_attr[:items][index][:amount]||= line.amount
    end

    post '/order', {params: order_attr}
    assert_equal("", response.body)

  end

  test "should new order force dublicate and different :firstname" do
    order = Order.last

    order_attr = {number: order.client.number, firstname: order.client.firstname + '1', lastname: order.client.lastname, post_index: order.client.post_index, ignore: true}
    order_attr[:items] ||= {}

    order.order_lines.each_with_index do |line, index|
      order_attr[:items][index] ||= {}
      order_attr[:items][index][:item_id] ||= line.item_id
      order_attr[:items][index][:amount]||= line.amount
    end

    post '/order', {params: order_attr}
    assert_equal("{\"error\":\"check user data\"}", response.body)

  end

  test "should new order force dublicate and different :lastname" do
    order = Order.last

    order_attr = {number: order.client.number, firstname: order.client.firstname, lastname: order.client.lastname + '1', post_index: order.client.post_index, ignore: true}
    order_attr[:items] ||= {}

    order.order_lines.each_with_index do |line, index|
      order_attr[:items][index] ||= {}
      order_attr[:items][index][:item_id] ||= line.item_id
      order_attr[:items][index][:amount]||= line.amount
    end

    post '/order', {params: order_attr}
    assert_equal("{\"error\":\"check user data\"}", response.body)

  end

  test "should new order force dublicate and different :post_index" do
    order = Order.last

    order_attr = {number: order.client.number, firstname: order.client.firstname, lastname: order.client.lastname, post_index: order.client.post_index + '1', ignore: true}
    order_attr[:items] ||= {}

    order.order_lines.each_with_index do |line, index|
      order_attr[:items][index] ||= {}
      order_attr[:items][index][:item_id] ||= line.item_id
      order_attr[:items][index][:amount]||= line.amount
    end

    post '/order', {params: order_attr}
    assert_equal("{\"error\":\"check user data\"}", response.body)

  end

  test "should new order without items" do
    order = Order.last

    order_attr = {number: order.client.number,
                  firstname: order.client.firstname,
                  lastname: order.client.lastname,
                  post_index: order.client.post_index + '1',
                  ignore: true}

    post '/order', {params: order_attr}
    assert_equal("{\"error\":\"Add line and items\"}", response.body)

  end

end
