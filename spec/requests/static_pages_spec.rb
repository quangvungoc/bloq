require 'spec_helper'

describe "StaticPages" do
  
  subject{page}

  describe "home page" do
  	before {visit root_path}

  	it {should have_title("Bloq Home")}

    describe "list entries" do
      let(:user) {FactoryGirl.create(:user)}
      let(:entry) {FactoryGirl.create(:entry, user: user)}

      it {should have_content("Entries")}
      it {should have_link(entry.title)}      
    end
  end
 
  describe "help page" do
  	before {visit help_path}

    it {should have_title("Bloq Help")}
  end

  describe "about page" do
    before {visit about_path}

    it {should have_title("Bloq About")}
  end

  it "should have the right links in layout" do
    visit root_path 

    click_link "About"
    expect(page).to have_title("Bloq About")

    click_link "Help"
    expect(page).to have_title("Bloq Help")

    click_link "Home"
    expect(page).to have_title("Bloq Home")

  end
end
