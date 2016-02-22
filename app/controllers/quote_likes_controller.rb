class QuoteLikesController < ApplicationController

  def index

  end

  def show

  end

  def new
    render inline: "#{params[:quote_id]}"
  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

end
