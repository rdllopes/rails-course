require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :titulo => "Titulo",
      :conteudo => "Conteudo"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Titulo/)
    rendered.should match(/Conteudo/)
  end
end
