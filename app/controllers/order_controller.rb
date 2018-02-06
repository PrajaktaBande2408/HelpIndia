class OrderController < ApplicationController
  def new

    @user = User.find(params[:user_id])

  end

  def index
  end

  def create
    p params
    @user = User.find(params[:user_id])
    @order = @user.orders.create(order_params)
    @order.save
    redirect_to user_order_index_path
  end
  def update

  end

  def show
    @user = User.find(params[:user_id])
    @order = @user.orders
    p @order
  end

  private
  def order_params
    params.require(:order).permit(:field1, :field2)
  end
end
