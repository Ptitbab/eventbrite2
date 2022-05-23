class OrdersController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    # Before the rescue, at the beginning of the method
    @event = Event.find(params[:event_id])
    @stripe_amount = @event.price.to_i * 100
    begin
      customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
      })
      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @stripe_amount,
      description: "Participation à l'evenement",
      currency: 'eur',
      })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_order_path
    end
    # After the rescue, if the payment succeeded
    Attendance.create(event:@event, attendee: current_user, stripe_customer_id: customer.id)

  end

end
