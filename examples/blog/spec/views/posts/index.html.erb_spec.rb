require 'spec_helper'

describe "posts/index" do
  before(:each) do
    2.times { FactoryGirl.create(:post) }
    @posts = Post.order(:created_at).page(params[:page]).per(10)
    assign(:posts, @posts)
  end

  it "renders a list of posts" do
    render
    post = @posts.all.first
    assert_select "tr>td", :text => post.titulo.to_s, :count => 1
    assert_select "tr>td", :text => post.conteudo.to_s, :count => 1
  end
end
