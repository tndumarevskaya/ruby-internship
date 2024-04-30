class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]
  before_action :check_logged_in, only: %i[check]

  # Отображает список заказов
  def index
    @orders = Order.all
    puts "params: #{params.inspect}"
  end
  
  # Отображает информацию о конкретном заказе
  def show
  end

  # Создает новый заказ
  def new
    @order = Order.new
  end

  # Редактирует существующий заказ
  def edit
  end

  # Создает новый заказ
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

  # Обновляет информацию о заказе
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

  # Удаляет заказ
  def destroy
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Подтверждает заказ
  def approve
    render json: params
  end

  # Выполняет вычисление
  def calc 
    render plain: rand(100)
  end 
  
  # Отображает информацию о первом заказе
  def first
    @order = Order.first
    render :show
  end

  # Проверяет возможность совершения заказа
  def check
    begin
      result = OrderService.check_order(check_params, session)

      render json: result.except(:status), status: result[:status]
    rescue ActionController::ParameterMissing => e
      render json: { result: false, message: 'Отсутствуют обязательные параметры.' }, status: :bad_request
    end
  end

  private
    # Устанавливает заказ
    def set_order
      @order = Order.find(params[:id])
    end

    # Параметры заказа
    def order_params
      params.require(:order).permit(:name, :status, :cost)
    end

    # Параметры заказа для проверки
    def check_params
      params.require(:check).permit(:cpu, :ram, :hdd_type, :hdd_capacity, :os)
    end

    # Проверка авторизации
    def check_logged_in
      unless logged_in?
        render json: { result: false, message: 'Войдите в систему, пожалуйста.' }, status: :unauthorized
      end
    end
end