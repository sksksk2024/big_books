# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[edit update destroy]

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show; end

  # GET /books/new
  def new
    # @book = Book.new
    @book = current_user.books.build
  end

  # GET /books/1/edit
  def edit; end

  # POST /books or /books.json
  def create
    @book = current_user.books.build(book_params)
  
    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /books/1 or /books/1.json
  def update
    if Author.exists?(params[:book][:author_id])
      respond_to do |format|
        if @book.update(book_params)
          format.html { redirect_to book_url(@book), notice: 'Book was successfully updated.' }
          format.json { render :show, status: :ok, location: @book }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @book.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to edit_book_path(@book), alert: 'The specified author does not exist.'
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def correct_user
    @book = current_user.books.find_by(id: params[:id])
    redirect_to books_path, notice: 'Not Authorized To Edit This Book' if @book.nil?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:book_name, :author_first_name, :author_last_name, :price, :user_id, :page_number,
                                 :publication_date, :author_id)
  end
end
