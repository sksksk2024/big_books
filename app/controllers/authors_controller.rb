class AuthorsController < ApplicationController
  before_action :set_book
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  # GET /authors or /authors.json
  def index
    @authors =
      if @book
        # If nested under a book, show authors associated with that book
        @book.authors.order(popularity_score: :desc)
      else
        # If standalone, show all authors
        Author.order(popularity_score: :desc)
      end
  end

  # GET /authors/1 or /authors/1.json
  def show
    @author = Author.find(params[:id])
  end

  # GET /books/:book_id/authors/new
  def new
    # For nested resources, @book is already set in a before_action
    # If nested under a book, initialize a new author associated with that book
    @author = current_user.authors.build
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /books/:book_id/authors or /authors.json
  def create
    # Create a new author with the provided parameters
    @author = Author.new(author_params)
    @author.user = current_user

    respond_to do |format|
      if @author.save
        # If author is successfully created, redirect to the new author's show page
        format.html { redirect_to author_path(@author), notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: author_path(@author) }
      else
        # If there are errors in author creation, render the new author form again
        format.html { render :new }
        format.json { render json: author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to author_path(@author), notice: "Author was successfully updated." }
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
    @author = @book ? @book.authors.find(params[:id]) : Author.find(params[:id])
  end


  def set_book
    @book = Book.find_by(id: params[:book_id]) if params[:book_id].present?
  end

  # Only allow a list of trusted parameters through.
  def author_params
    params.require(:author).permit(:popularity_score, :name)
  end
end
