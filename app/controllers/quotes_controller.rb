class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :create, :edit, :update, :destroy]
  before_action :is_creator?, only: [:edit, :update, :destroy]

  def index
    @quotes = Book.find(params[:book_id]).quotes
  end

  def show
    @quote = Quote.find(params[:id])
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(text: quote_params[:text])
    @quote.user = current_user if current_user
    @quote.book = @book if @book

    respond_to do |format|
      if @quote.save
        format.html { redirect_to book_path(@book), notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @book}
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
      respond_to do |format|
        if @quote.update_attributes(quote_params)
          format.html { redirect_to book_path(@book), notice: 'Quote was successfully updated.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
  end

  def destroy
    begin
      @quote.destroy
      respond_to do |format|
        format.html { redirect_to book_path(@book), notice: 'Quote was successfully destroyed.' }
        format.json { head :no_content }
      end
    rescue => ex
      render_500
    end
  end

  private

  def quote_params
    params.require(:quote).permit(:id, :text)
  end

  def set_quote
    @book = Book.find(params[:book_id])
    @quotes = @book.quotes
    @quote = @quotes.find(params[:id])

    render_500 unless @book
  end

  def is_creator(user)
    self.user == user
  end

  def is_creator?
    @quote = Quote.find(quote_params[:id]) unless @quote

    if current_user == @quote.user
      true
    else
      false
      render_500
    end
  end
end
