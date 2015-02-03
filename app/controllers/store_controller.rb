#encoding: utf-8

class StoreController < ApplicationController
  before_filter :check_user_logged, :only => [:checkout, :confirm, :save_purchase]

  def add_to_cart
    if (params[:ticket_num] == "")
      redirect_to request.referer, :notice => "Scegliere il numero di biglietti" and return
    end
    begin
      ticket_type = TicketType.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid ticket type #{params[:id]}")
      redirect_to_index("Tipologia di biglietto non valida")
    else
      @cart = find_cart
      @cart.add_ticket_type(ticket_type, params[:ticket_num].to_i)
    end
    redirect_to :action => :show_cart
  end

  def remove_from_cart
    ticket_type_id = params[:id].to_i;
    @cart = find_cart
    @cart.items.delete_if do |item|
      item.ticket_type.id == ticket_type_id
    end
    redirect_to :action => :show_cart
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index("Il tuo carrello è vuoto")
  end

  def show_cart
    @cart = find_cart
  end

  def checkout
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Il tuo carrello è vuoto")
    else
      @purchase = Purchase.new
    end

    render :select_payment
  end

  def confirm
    if (params[:purchase][:pay_type] == "")
      redirect_to request.referrer, :notice => "Scegliere un tipo di pagamento"  and return
    end
    @cart = find_cart
    @purchase = Purchase.new(params[:purchase])
  end

  def save_purchase
    @cart = find_cart
    @purchase = Purchase.new(params[:purchase])
    @purchase.user = current_user
    @purchase.add_tickets_from_cart(@cart)
    @purchase.total_price = @cart.total_price
    if @purchase.save
      UserMailer.purchase_confirmation(current_user, @purchase).deliver
      session[:cart] = nil
      redirect_to_index("Grazie per il tuo acquisto")
    else
      puts @purchase.errors.full_messages.join(",")
      render :select_payment
    end
  end

  private

  def find_cart
      session[:cart] ||= Cart.new
  end

  def redirect_to_index(msg)
    flash[:notice] = msg
    redirect_to :controller => :events, :action => :index
  end

end
