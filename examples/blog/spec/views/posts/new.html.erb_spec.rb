require 'spec_helper'

describe "posts/new" do
  before(:each) do
    assign(:post, stub_model(Post,
      :titulo => "MyString",
      :conteudo => "MyString"
    ).as_new_record)
  end

  it "renders new post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", posts_path, "post" do
      assert_select "input#post_titulo[name=?]", "post[titulo]"
      assert_select "input#post_conteudo[name=?]", "post[conteudo]"
    end
  end
end
