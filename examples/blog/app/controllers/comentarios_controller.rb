class ComentariosController < ApplicationController
  def new
    @comentario = Comentario.new
    @post = Post.find(params[:post_id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comentario }
    end
  end

  def edit
    @comentario = Comentario.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def create
    @comentario = Comentario.create!(params[:comentario].merge({:post_id => params[:post_id]}))
    @post = Post.find(params[:post_id])
    
    redirect_to post_url(@post)
  end

  def update
     @comentario = Comentario.find(params[:id])

    respond_to do |format|
      if @comentario.update_attributes(params[:comentario])
        format.html { redirect_to @comentario, notice: 'Comentario was successfully created.' }
        format.json { render json: @comentario, status: :created, location: @comentario }
      else
        format.html { render action: "edit" }
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comentario = Comentario.find(params[:id])
    @comentario.destroy

    respond_to do |format|
      format.html { redirect_to comentarios_url }
      format.json { head :no_content }
    end
  end
end