require 'spec_helper'

describe "User Pages" do
  subject {page}

  describe "index" do
  end

  describe "show an user" do
  end

  describe "sign up page" do
    before {visit signup_path}
    it {should have_title("Sign up")}
    it {should have_content("Sign up")}

    describe "create a new account" do
      let(:submit) {"Create my account"}

      describe "with invalid infos" do
        before {click_button submit}
        it {should have_content("error")}
      end

      describe "with valid infos" do
        before do
          fill_in "Name", with: "QQ"
          fill_in "Email", with: "qq@bloq.com"
          fill_in "Email confirmation", with: "qq@bloq.com"
          fill_in "Password", with: "password"
          fill_in "Confirm password", with: "password"

          click_button submit
        end

        it {should have_content("Welcome to Bloq")}
      end
      
    end
  end

end
