class AuthorsController < ApplicationController
  before_action :set_book
  before_action :set_author, only: %i[show edit update destroy]

  # GET /authors or /authors.json
  def index
    if @book
      # If nested under a book, show authors associated with that book
      @authors = @book.authors.order(popularity_score: :desc)
    else
      # If standalone, show all authors
      @authors = Author.order(popularity_score: :desc)
    end
  end

  # GET /authors/1 or /authors/1.json
  def show
  end

  # GET /books/:book_id/authors/new
  def new
    @author = 
      if @book
        @book.authors.new
      else
        Author.new
      end
  end

  # GET /authors/1/edit
  def edit
    @author = Author.find(params[:id])
  end

  # POST /books/:book_id/authors or /authors.json
  def create
    author_params = author_params.merge(book_id: params[:book_id]) if @book
    author = Author.new(author_params)

    respond_to do |format|
      if author.save
        format.html { redirect_to author_url(author), notice: "Author was successfully created." }
        format.json { render :show, status: :created, location: author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to author_url(author), notice: "Author was successfully updated." }
        format.json { render :show, status: :ok, location: author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1 or /authors/1.json
  def destroy
    author.destroy

    respond_to do |format|
      format.html { redirect_to authors_url, notice: "Author was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_author
    @author =
      if @book
        @book.authors.find(params[:id])
      else
        Author.find(params[:id])
      end
  end

  def set_book
    @book = Book.find_by(id: params[:book_id]) if params[:book_id]
  end

  # Only allow a list of trusted parameters through.
  def author_params
    params.require(:author).permit(:first_name, :last_name, :popularity_score)
  end
end
