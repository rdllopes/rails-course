require 'spec_helper'

describe Post do
  it "should not save a post without title" do
    post = FactoryGirl.build(:post, :titulo => "")
    post.should_not be_valid
  end
end
