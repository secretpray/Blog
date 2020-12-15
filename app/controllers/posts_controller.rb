class PostsController < ApplicationController

  before_action :authenticate_user!, except: %i[index show]
  before_action :find_post, only: %i[show edit create update destroy]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, notice: 'Post succefully created'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post succefully updated' #t('.success', post: @test.title)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, notice: 'Post succefully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end

end
