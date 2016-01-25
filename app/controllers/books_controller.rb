require 'date'

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_genres, only: [:show, :edit, :update, :destroy]
  # GET /books
  # GET /books.json
  def index
    @books = Book.where("created_at > ? AND is_draft = false", p(Date.today - 7).beginning_of_day)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    render_500 unless is_creator?
  end

  # POST /books
  # POST /books.json
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

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
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
      render_500
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if is_creator?

      destroy_genre_connections
      @book.destroy

      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      render_500
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    begin
      @book = Book.find(params[:id])
    rescue => ex
      render_500 unless @book
    end
  end

  def set_genres
    begin
      @genres = Genre.all
    rescue => ex
      render_500 unless @genres
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
      puts "________________________________\n\n\n\n\n\n\n\n\n\n\n"
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
