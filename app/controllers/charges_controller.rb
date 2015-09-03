class ChargesController < ApplicationController

  before_filter :authenticate_user!

  class Amount
    def self.default
      @amount = 10_00
    end
  end

  # def new
  #   @stripe_btn_data = {
  #       key: "#{ Rails.configuration.stripe[:publishable_key] }",
  #       description: "Premium Membership - #{current_user.username}",
  #       amount: Amount.default
  #   }
  # end

  def create
    customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        customer: customer.id, # Note -- this is NOT the user_id in your app
        amount: Amount.default,
        description: "Premium Membership - #{current_user.email}",
        currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    current_user.update_attribute(:role, 'premium')
    redirect_to user_path(current_user)


      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
    end
end
