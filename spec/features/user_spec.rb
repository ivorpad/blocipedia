require 'rails_helper'

  describe "User" do
    describe ".sign_in" do
      before do
        visit new_user_session_path
      end

      it "when logged in" do
        expect(page).to have_content('Didn\'t receive confirmation instructions?')
      end

    end
  end
