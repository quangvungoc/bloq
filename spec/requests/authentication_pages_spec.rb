require 'spec_helper'

describe "Authentication Pages" do
  subject {page}

  describe "sign in page" do
    before {visit signin_path}

    it {should have_content("Sign in")}
    it {should have_title("Sign in")}
  end

  describe "sign in" do
    before {visit signin_path}

    describe "with invalid infos" do
      before {click_button "Sign in"}

      it {should have_title("Sign in")}
      it {should have_selector("div.alert.alert-error")}
    end

    describe "with valid infos" do
      let(:user) {FactoryGirl.create(:user)}
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it {should have_title(user.name)}
      it {should have_link('Profile',       href: user_path(user))}
      it {should have_link('Sign out',      href: signout_path)}
      it {should_not have_link('Sign in',   href: signin_path)}
      it {should have_link("New entry")}

      describe "then sign out" do
        before {click_link "Sign out"}

        it {should have_link("Sign in", href: signin_path)}
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) {FactoryGirl.create(:user)}

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before {visit edit_user_path(user)}
          it {should have_title('Sign in')}
        end

        describe "submitting to the update action" do
          before {patch user_path(user)}
          specify {expect(response).to redirect_to(signin_path)}
        end
      end
    end

    describe "as wrong user" do
      let(:user) {FactoryGirl.create(:user)}
      let(:wrong_user) {FactoryGirl.create(:user, email: "wrong@example.com",
                                            email_confirmation: "wrong@example.com")}
      before {sign_in user, no_capybara: true}

      describe "submitting a GET request to the Users#edit action" do
        before {get edit_user_path(wrong_user)}
        specify {expect(response).to redirect_to(root_url)}
      end

      describe "submitting a PATCH request to the Users#update action" do
        before {patch user_path(wrong_user)}
        specify {expect(response).to redirect_to(root_url)}
      end
    end

    describe "as correct user" do
      let(:user) {FactoryGirl.create(:user)}

      before do
        visit signin_path
        sign_in user
        visit edit_user_path(user)
      end

      describe "edit infos" do
        let(:new_email) {"aoeu@bloq.com"}

        before do
          fill_in "Email", with: new_email
          fill_in "Confirm Email", with: new_email
          fill_in "Password", with: "aoueaoeu"
          fill_in "Confirm Password", with: "aoueaoeu"

          click_button "Save changes"
        end

        it {should have_content("Profile updated")}
      end      
    end

    describe "in the Entries controller" do
      describe "submitting to the create action" do
        before { post entries_path }
        specify { expect(response).to redirect_to(signin_path) }
      end

      describe "submitting to the destroy action" do
        before { delete entry_path(FactoryGirl.create(:entry)) }
        specify { expect(response).to redirect_to(signin_path) }
      end
    end
  end
end
