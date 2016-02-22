class QuotesController < ApplicationController
  def index
    @quotes = Book.find(params[:book_id]).quotes
  end

  def show
    @quote = Quote.find(params[:id])
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
    # user = current_user
    user = User.find(1);
    quote = Quote.find(2);

    render inline: "#{user.email} | likes: #{user.likes.count} | #{quote.quote_likes.joins(current_user.likes).count}"

    #render inline: "UserLike: #{user.likes.count } <br/> QuoteLike: #{ QuoteLike.where(quote_id: params[:id]).count }".html_safe
  end

  private

  def quote_params
    params.require(:quote).permit(:id, :text)
  end
end
