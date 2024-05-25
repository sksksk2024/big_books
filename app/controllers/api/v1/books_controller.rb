# frozen_string_literal: true
module Api
  module V1
class BooksController < ApplicationController
      respond_to :json

      before_action :set_book, only: %i[show edit update destroy]
      before_action :authenticate_user!, except: %i[index show]

      # GET /books or /books.json
      def index
        @books = Book.all
        if params[:q].present?
          query = "%#{params[:q]}%"
          @books = @books.where("book_name LIKE ?", query)
        end
        @books = @books.paginate(page: params[:page], per_page: 10)

        respond_to do |format|
          format.html { render plain: "This is an API controller. HTML format is not supported.", status: :not_acceptable } # Renders the default index.html.erb
          format.js   # Renders index.js.erb
          format.json { render json: @books } # Renders JSON representation of @books
        end
      end
      
      

      # GET /books/1 or /books/1.json
      def show
        authorize @book
        respond_to do |format|
          format.html { render plain: "This is an API controller. HTML format is not supported.", status: :not_acceptable }
          format.json { render json: @book }
        end
      end

      # GET /books/new
      def new
        # @book = Book.new
        @book = current_user.books.build
        respond_to do |format|
          format.html { render plain: "This is an API controller. HTML format is not supported.", status: :not_acceptable }
          format.json { render json: @book }
        end
      end

      # GET /books/1/edit
      def edit
        authorize @book
      end

      # POST /books or /books.json
      def create
        @book = current_user.books.build(book_params)
        authorize @book
        
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
        authorize @book

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
  end
end