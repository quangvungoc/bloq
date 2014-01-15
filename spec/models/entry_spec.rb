require 'spec_helper'

describe Entry do
  let(:user) {FactoryGirl.create(:user)}
  before {@entry = user.entries.build(title: "Title", body: "Content")}

  subject {@entry}

  it {should respond_to(:title)}
  it {should respond_to(:body)}
  it {should respond_to(:user_id)}
  its(:user) {should eq user}

  it {should be_valid}

  describe "with blank title" do
    before {@entry.title = " "}
    it {should_not be_valid}
  end

  describe "with too long title" do
    before {@entry.title = "a" * 251}
    it {should_not be_valid}
  end

  describe "with blank content" do
    before {@entry.body = " "}
    it {should_not be_valid}
  end

end
