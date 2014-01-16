require 'spec_helper'

describe "Entry Pages" do
  let(:user) {FactoryGirl.create(:user)}
  before do
    @entry = user.entries.build(title: "Title", body: "Content").save!
  end

  subject {page}

  describe "comment section" do
    before {visit entry_path(@entry)}
    it {should have_content("Comments")}
  end

  describe "comment form" do
    describe "when not signed in" do
    end

    describe "when signed in" do
    end
  end
end
