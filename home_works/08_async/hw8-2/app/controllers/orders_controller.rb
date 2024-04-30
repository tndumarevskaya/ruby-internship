class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    #new_orders=[]
    #Order.includes(:networks,:tags).each do |order|
    #  new_orders<<{
    #    name: order.name,
    #    status: order.status,
    #    cost: order.cost,
    #    created_at: order.created_at,
    #    updated_at: order.updated_at,
    #    tags: order.tags.map{ |tag| { id: tag.id, name: tag.name } },
    #    networks_count: order.networks.size
    #  }
    #end
    #render json: { orders: new_orders }
    params[:per_page] ||= 30
    params[:page] ||= 1
    per_page=params[:per_page].to_i
    page=params[:page].to_i
    @orders = Order.order(id: :desc).limit(per_page).offset(per_page * (page - 1))
  end


  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  def calc 
    r=Random.new
    render plain: r.rand().to_s
  end

  def first
    @order = Order.first
    render :show
  end

  def approve
    render json: params
  end
  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:name, :status, :cost)
    end
end
