require 'date'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.where("created_at > ? AND is_draft = false", p(Date.today - 7).beginning_of_day)
  end

  def show
    redirect_to(books_path, alert: 'Sorry, but you can`t see this book.') if @book.is_draft? && current_user != @book.user
  end

  def new
    @book = Book.new
  end

  def edit
    redirect_to(book_path(@book), alert: 'Sorry, but you can`t edit this.') unless is_creator?
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    respond_to do |format|
      if @book.save
        create_genre_connections
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if is_creator?

      update_genre_connections

      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to @book, notice: 'Book was successfully updated.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end

    else
      redirect_to(book_path(@book), alert: 'Sorry, but you can`t edit this book.')
    end
  end

  def destroy
    if is_creator?

      destroy_genre_connections
      @book.destroy

      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to(book_path(@book), alert: 'Sorry, but you can`t delete this book.')
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    begin
      @book = Book.find(params[:id])
      @quotes = @book.quotes
      set_genres
    rescue => ex
      redirect_to(books_path, alert: 'Sorry, but something is went wrong with book.') unless @book
    end
  end

  def set_genres
    begin
      @genres = Genre.all
    rescue => ex
      redirect_to(books_path, alert: 'Sorry, but something is went wrong with genres.') unless @genres
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def book_params
    params.require(:book).permit(:name, :author, :picture, :context, :is_draft)
  end

  def is_creator?
    current_user.id == @book.user_id
  end

  def create_genre_connections
    book_genres = params[:genre]

    @genres = Genre.all
    @genres.each { |genre|
      if book_genres[genre.id.to_s] == 1.to_s
        connection = BookGenre.new
        connection.genre_id = genre.id
        connection.book_id = @book.id

        begin
          connection.save
        rescue => ex
          connection = nil
        end
      end
    }
  end

  def  update_genre_connections
    book_genres = params[:genre]
    @genres = Genre.all

    @genres.each { |genre|
      conns = BookGenre.where(:book_id => @book.id, :genre_id => genre.id)
      conns.each { |e|
        e.destroy
      }
    }

    @genres.each { |genre|

      connection = nil
      begin
        connection = BookGenre.find(book_id: @book.id, genre_id: genre.id)
      rescue => ex
        connection = nil
      end

      if book_genres[genre.id.to_s] == 0.to_s
        connection.destroy! if connection != nil
      else
        if book_genres[genre.id.to_s] == 1.to_s
          if connection == nil
            connection = BookGenre.new

            connection.genre_id = genre.id
            connection.book_id = @book.id

            connection.save

            begin
              connection.save
            rescue => ex
              connection = nil
            end
          end
        end
      end
    }
  end

  def destroy_genre_connections
    connections = BookGenre.where(book_id: @book.id)

    connections.each { |conn|
      conn.destroy
    }
  end
end
