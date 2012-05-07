class LineItemsController < ApplicationController
  respond_to :html
  
  def index
    @line_items = LineItem.all
    respond_with @line_items
  end

  def reset_s_c
    session[:counter] = 0
  end
  
  def show
    @line_item = LineItem.find(params[:id])
    respond_with @line_item
  end

  def new
    @line_item = LineItem.new
    respond_with @line_item
  end

  def edit
    @line_item = LineItem.find(params[:id])
  end

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.line_items.build
    @line_item.product = product
    if @line_item.save
      reset_s_c
      flash[:notice] =  'Line item was successfully created.'
    end
    respond_with(@line_item, location: @line_item.cart)
  end

  def update
    @line_item = LineItem.find(params[:id])
    flash[:notice] = 'Line item was successfully updated.' if @line_item.update_attributes(params[:line_item])
    respond_with @line_item
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    respond_with(@line_item, location: line_items_url) 
  end
end
