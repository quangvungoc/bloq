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

  describe "edit user page" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      visit signin_path
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it {should have_content("Update your profile")}
      it {should have_title("Bloq Edit user")}
      it {should have_link("change", href: "http://gravatar.com/emails")}
    end

    describe "with invalid infos" do
      before {click_button "Save changes"}

      it {should have_content("error")}
    end
  end

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", 
                                email: "bob@example.com",
                                email_confirmation: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", 
                                email: "ben@example.com",
                                email_confirmation: "ben@example.com")
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    it "should list each user" do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
      end
    end
  end

  describe "profile page" do
    let(:user) {FactoryGirl.create(:user)}
    let!(:m1) {FactoryGirl.create(:entry, user: user, title: "Entry 1", body: "Foo")}
    let!(:m2) {FactoryGirl.create(:entry, user: user, title: "Entry 2", body: "Bar")}

    before {visit user_path(user)}

    it {should have_content(user.name)} 
    it {should have_title(user.name)}

    describe "entries" do
      it {should have_content(m1.title)}
      it {should have_content(m1.body)}
      it {should have_content(m2.title)}
      it {should have_content(m2.body)}
      it {should have_content(user.entries.count)}
    end
  end

end
