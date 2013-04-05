require 'spec_helper'
describe ComentariosController do
  def valid_post_attributes
    { "titulo" => "MyString", "comentarios" => [] }
  end
  def valid_comentario_attributes
    { "autor" => "autor", "texto" => "texto" }
  end
  def valid_session
    {}
  end
  describe "create comentario" do
    render_views
    it "should persist comentario" do
      my_post = Post.create! valid_post_attributes
      #comentario = Comentario.new(valid_comentario_attributes).merge({:post_id => post.id}))
      post :create, {:comentario => valid_comentario_attributes, :post_id => my_post.id}, valid_session
      Comentario.all(:post_id => my_post.id.to_s).should_not be_empty
    end    
    it "should redirect post/show" do
      my_post = Post.create! valid_post_attributes
      #comentario = Comentario.new(valid_comentario_attributes).merge({:post_id => post.id}))
      post :create, {:comentario => valid_comentario_attributes, :post_id => my_post.id}, valid_session
      response.location.should match Regexp.new("posts\/#{my_post.id.to_s}")
    end
  end
end