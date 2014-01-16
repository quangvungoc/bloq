class StaticPagesController < ApplicationController
  def home
    if signed_in? 
      @items = current_user.feed.paginate(page: params[:page])
    else
      @items = Entry.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
end
