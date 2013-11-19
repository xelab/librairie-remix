require 'test_helper'

class SaleLinesControllerTest < ActionController::TestCase
  setup do
    @sale_line = sale_lines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_lines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale_line" do
    assert_difference('SaleLine.count') do
      post :create, sale_line: { book_id: @sale_line.book_id, buy_quantity: @sale_line.buy_quantity, deposit_quantity: @sale_line.deposit_quantity, price: @sale_line.price, sale_id: @sale_line.sale_id }
    end

    assert_redirected_to sale_line_path(assigns(:sale_line))
  end

  test "should show sale_line" do
    get :show, id: @sale_line
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sale_line
    assert_response :success
  end

  test "should update sale_line" do
    patch :update, id: @sale_line, sale_line: { book_id: @sale_line.book_id, buy_quantity: @sale_line.buy_quantity, deposit_quantity: @sale_line.deposit_quantity, price: @sale_line.price, sale_id: @sale_line.sale_id }
    assert_redirected_to sale_line_path(assigns(:sale_line))
  end

  test "should destroy sale_line" do
    assert_difference('SaleLine.count', -1) do
      delete :destroy, id: @sale_line
    end

    assert_redirected_to sale_lines_path
  end
end
