class EntriesController < ApplicationController
  before_action :signed_in_user,  only: [:create, :destroy]
  before_action :admin_user,    only: [:destroy]

  def index
  end

  def new
    @entry = current_user.entries.build if signed_in?
  end

  def show
    @entry = Entry.find(params[:id])
    @items = @entry.comments
    @comment = Comment.new
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Posted successfully!"
      redirect_to root_url
    else
      @items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @entry.destroy
    redirect_to root_url
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :body)
  end

  def correct_user
    @entry = current_user.entries.find_by(id: params[:id])
    redirect_to root_url if @entry.nil?
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end