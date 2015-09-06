class ChargesController < ApplicationController

  before_filter :authenticate_user!

  class Amount
    def self.default
      @amount = 10_00
    end
  end

  def create

    customer = Stripe::Customer.create(
        email: current_user.email,
        card: params[:stripeToken]
    )
    current_user.customer_id = customer.id
    return unless customer.subscriptions.data.empty?
    customer.subscriptions.create(plan: 'premium')

    charge = Stripe::Charge.create(
        customer: customer.id, # Note -- this is NOT the user_id in your app
        amount: Amount.default,
        description: "Premium Membership - #{current_user.email}",
        currency: 'usd'
    )

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    current_user.update_attribute(:role, 'premium')
    redirect_to edit_user_registration_path


      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to edit_user_registration_path
  end

  def downgrade
    customer = Stripe::Customer.retrieve(current_user.customer_id)
    subscription_id = customer.subscriptions.data.first.id
    customer.subscriptions.retrieve(subscription_id).delete
    current_user.update_attributes(role: 'standard')
    redirect_to edit_user_registration_path
  end

end
