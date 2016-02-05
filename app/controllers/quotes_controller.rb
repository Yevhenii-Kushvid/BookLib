class QuotesController < ApplicationController
  #before_action :is_creator?, only: [:edit, :update, :destroy]

  def index
    @quotes = Book.find(params[:book_id]).quotes
  end

  def show
    @quote = Quote.find(params[:id])
  end

  def new
    if book.user == current_user
      @quote = Quote.new
    else
      render_500
    end
  end

  def create
    book = Book.find(params[:book_id])
    if book.user == current_user
      @quote = Quote.new(text: quote_params[:text])
      @quote.user = current_user if current_user
      @quote.book = book if book

      respond_to do |format|
        if @quote.save
          format.html { redirect_to book_path(book), notice: 'Quote was successfully created.' }
          format.json { render :show, status: :created, location: book}
        else
          format.html { render :new }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    else
      render_500
    end
  end

  def edit
    quote = Quote.find(params[:id])
    if current_user == quote.user
      @quote = quote
    else
      render_500
    end
  end

  def update
    @quote = Quote.find(quote_params[:id])
    if current_user == @quote.user
      book = Book.find(params[:book_id])
      respond_to do |format|
        if @quote.update_attributes(text: quote_params[:text])
          format.html { redirect_to book_path(book), notice: 'Quote was successfully updated.' }
          format.json { render :show, status: :ok, location: book }
        else
          format.html { render :edit }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    else
      render_500
    end
  end

  def destroy
    @quote = Quote.find(params[:id])
    if current_user == @quote.user
      begin
        book = Book.find(params[:book_id])
        @quote.destroy
        respond_to do |format|
          format.html { redirect_to book_path(book), notice: 'Quote was successfully destroyed.' }
          format.json { head :no_content }
        end
      rescue => ex
        render_500
      end
    else
      render_500
    end
  end

  private
  def quote_params
    params[:quote]
  end
end
