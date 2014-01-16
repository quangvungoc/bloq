require 'spec_helper'

describe Comment do
  before do
    @user = FactoryGirl.create(:user)
    @entry = @user.entries.build(title: "Title", body: "Content")
    @entry.save!
    @comment = @user.comments.build(content: "Comment content", entry_id: @entry.id)
  end

  subject {@comment}

  it {should be_valid}

  describe "when userid is nil" do
    before {@comment.user_id = nil}
    it {should_not be_valid}
  end

  describe "when entryid is nil" do
    before {@comment.entry_id = nil}
    it {should_not be_valid}
  end

  describe "when content is nil" do
    before {@comment.content = nil}
    it {should_not be_valid}
  end
end
