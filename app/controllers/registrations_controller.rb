class RegistrationsController < Devise::RegistrationsController
  def edit
    @amount = 10_00

    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Premium Membership - #{current_user.username}",
        amount: @amount
    }
  end
end