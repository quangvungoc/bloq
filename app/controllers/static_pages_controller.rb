class StaticPagesController < ApplicationController
  def home
    @items = Entry.paginate(page: params[:page])
  end

  def help
  end

  def about
  end
end
