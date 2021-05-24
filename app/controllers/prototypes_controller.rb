class PrototypesController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    #テーブルから必要なデータを取得できる↑
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def create
    @prototype = Prototype.new(prototype_params)
    @prototype.user_id = current_user.id
    if @prototype.save
      redirect_to root_path      
    else
      render :new
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to prototypes_path
  end

  def edit
    @prototype = Prototype.find(params[:id])
    if @prototype.user == current_user
      render "edit"
    else
      redirect_to root_path
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to prototype_path
    else
      render :edit
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
