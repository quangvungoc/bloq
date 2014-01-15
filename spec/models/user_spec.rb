require 'spec_helper'

describe User do
  before {@user = User.new(name: "Quang", email: "qq@bloq.com", 
                          email_confirmation: "qq@bloq.com",
  												password: "password", 
  												password_confirmation: "password")}

  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:remember_token)}

  subject {@user}

  describe "when user name is nil" do
    before {@user.name = nil}
    it {should_not be_valid}
  end

  describe "email confirmation" do
    describe "should not be valid when email confirmation is nil" do
      before {@user.email_confirmation = nil}
      it {should_not be_valid}
    end

    describe "should not be valid when email not matched" do
      before {@user.email_confirmation = "oo@bloq.com"}
      it {should_not be_valid}
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "entry associations" do

    before { @user.save }
    let!(:older_entry) do
      FactoryGirl.create(:entry, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_entry) do
      FactoryGirl.create(:entry, user: @user, created_at: 1.hour.ago)
    end

    it "should destroy associated entrys" do
      entries = @user.entries.to_a
      @user.destroy
      expect(entries).not_to be_empty
      entries.each do |entry|
        expect(Entry.where(id: entry.id)).to be_empty
      end
    end
  end
end
