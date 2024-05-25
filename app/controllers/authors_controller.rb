class AuthorsController < ApplicationController
  before_action :set_book
  before_action :set_author, only: [:show, :edit, :update, :destroy]
  before_action :authorize_author, only: [:show, :edit, :update, :destroy]
  
  # GET /authors or /authors.json
  def index
    # Initialize the authors query
    @authors = Author.all
  
    # If there are search parameters, filter the authors
    if params[:q].present?
      search_term = "%#{params[:q]}%"
      @authors = @authors.where('first_name LIKE ? OR biography LIKE ?', search_term, search_term)
    end
  
    # Order by popularity_score in descending order
    @authors = @authors.order(popularity_score: :desc)
  
    # Paginate the results
    @authors = @authors.paginate(page: params[:page], per_page: 10)
  end

  # GET /authors/1 or /authors/1.json
  def show
  end

  # GET /books/:book_id/authors/new
  def new
    # For nested resources, @book is already set in a before_action
    # If nested under a book, initialize a new author associated with that book
    @book = Book.find(params[:book_id]) if params[:book_id]
    @book.authors.build
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /books/:book_id/authors or /authors.json
  def create
    # Create a new author with the provided parameters
    @author = Author.new(author_params)
    @book = Book.find(params[:book_id]) if params[:book_id]
    @book.authors << author

    respond_to do |format|
      if @author.save
        format.html { redirect_to author_url(@author), notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
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
    @author = Author.find(params[:id])
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: "Author was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_author
    @author = Author.find(params[:id])  
  end

  def set_book
    @book = Book.find(params[:book_id]) if params[:book_id]
  end

  def authorize_author
    authorize(@author)
  end

  # Only allow a list of trusted parameters through.
  def author_params
    params.require(:author).permit(:popularity_score, :name)
  end
end
