class StaticPagesController < ApplicationController
  def home
    if signed_in? 
      @feed = current_user.feed.paginate(page: params[:feed_page]).per_page(3)
    end
    @items = Entry.all.paginate(page: params[:page]).per_page(3)
  end

  def help
  end

  def about
  end
end
