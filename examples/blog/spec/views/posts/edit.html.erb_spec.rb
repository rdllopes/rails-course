require 'spec_helper'

describe "posts/edit" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :titulo => "MyString",
      :conteudo => "MyString"
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", post_path(@post), "post" do
      assert_select "input#post_titulo[name=?]", "post[titulo]"
      assert_select "input#post_conteudo[name=?]", "post[conteudo]"
    end
  end
end
