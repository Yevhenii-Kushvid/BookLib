class QuotesController < ApplicationController
  def index
    @quotes = Book.find(params[:book_id]).quotes
  end

  def show
    @quote = Quote.find(params[:id])
    @total_quote_likes = @quote.quote_likes.count
    @i_can_like_it = current_user.likes.joins( :quote_like ).merge( @quote.quote_likes ).count == 0
  end

  def new
    book = Book.find(params[:book_id])
    if book.user == current_user
      @quote = Quote.new
    else
      redirect_to book_path(book), alert: 'Sorry, but you can`t create quote for this book.'
    end
  end

  def create
    book = Book.find(params[:book_id])
    if book.user == current_user
      @quote = Quote.new(quote_params)
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
      redirect_to book_path(book), notice: 'Sorry, but you can`t create quotes for this book.'
    end
  end

  def edit
    quote = Quote.find(params[:id])
    if quote.user == current_user
      @quote = quote
    else
      redirect_to book_path(book), notice: 'Sorry, but you can`t edit quotes for this book.'
    end
  end

  def update
    @quote = Quote.find(quote_params[:id])
    if current_user == @quote.user
      book = Book.find(params[:book_id])
      respond_to do |format|
        if @quote.update_attributes(quote_params)
          format.html { redirect_to book_path(book), notice: 'Quote was successfully updated.' }
          format.json { render :show, status: :ok, location: book }
        else
          format.html { render :edit }
          format.json { render json: @quote.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to book_path(book), notice: 'Sorry, but you can`t edit quotes for this book.'
    end
  end

  def destroy
    @quote = Quote.find(params[:id])
    if @quote.user == current_user
        book = Book.find(params[:book_id])
        @quote.destroy
        respond_to do |format|
          format.html { redirect_to book_path(book), notice: 'Quote was successfully destroyed.' }
          format.json { head :no_content }
        end
    else
      redirect_to book_path(book), notice: 'Sorry, but you can`t delete quotes for this book.'
    end
  end

  def like
    # show
    @quote = Quote.find(params[:id])
    @total_quote_likes = @quote.quote_likes.count

    # add НУЖНО СДЕЛАТЬ КАК ТРАНЗАКЦИЮ
    if @quote.can_i_like_it?(current_user)
      like = Like.create(user: current_user)
      like.quote = @quote

      # render final like count
      render inline: "#{@total_quote_likes + 1}"
    else
      # remove like form this quote
      @quote.likes.where(user: current_user).first.destroy if @quote;

      # render final like count
      render inline: ""
    end

  end

  private

  def quote_params
    params.require(:quote).permit(:id, :text)
  end
end
