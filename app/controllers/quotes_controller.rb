class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]
  before_action :is_creator?, only: [:edit, :update, :destroy]

  def index
    @quote = Book.find(params[:book_id]).quotes.all
  end

  def show
    @quote = Book.find(params[:book_id]).quotes.find(params[:id])
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new
    @quote.user_id = current_user.id
    @quote.book_id = params[:book_id]
    @quote.text    = params[:quote][:text]

    p "\n\n"
    p params[:quote]
    p "\n\n"
    respond_to do |format|
      if @quote.save

        params[:id] = @quote.id

        format.html { redirect_to book_path(@quote.book_id), notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote}
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    render_500 unless is_creator?
  end

  def update
      quotes_params = params[:quote]

      @quote = Book.find(params[:book_id]).quotes.all.find(quotes_params[:id])

      p "\n\n++++++++++\n\n"
      p params
      p "\n\n++++++++++\n\n"

      @quote.text = quotes_params[:text]

      respond_to do |format|
        if @quote.save
          format.html { redirect_to book_path(@quote.book_id), notice: 'Quote was successfully updated.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
  end

  def destroy
      @quote.destroy

      respond_to do |format|
        format.html { redirect_to book_path(@book.id), notice: 'Quote was successfully destroyed.' }
        format.json { head :no_content }
      end
  end

  def quotes_path
    book_quotes
  end

  private

  def set_quote
      begin
        @book = Book.find(params[:book_id])
        @quotes = @book.quotes.all
        @quote = @quotes.find(params[:id])
      rescue => ex
        render_500 unless @book
      end
  end


  def is_creator?
    @quote = Book.find(params[:book_id]).quotes.all.find(params[:quote][:id])

    if current_user.id == @quote.user_id
      true

    else
      false
      render_500
    end
  end
end
