class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order(:created_at).reverse_order
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.js { render layout: false, notice: 'Post created!' }
      else
        format.json { render json: @posts.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
        if @post.update(post_params)
          format.js { render layout: false, notice: 'Post updated!' }
        else
          format.json { render json: @posts.errors, status: :unprocessable_entity }
        end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.js { render nothing: false, notice: 'Post destroyed!' }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
