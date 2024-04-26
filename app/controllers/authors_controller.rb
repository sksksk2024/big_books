class AuthorsController < ApplicationController
  before_action :set_book
  before_action :set_author

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
    @book = Book.find(params[:book_id]) if params[:book_id].present?
    if @book
      # If nested under a book, initialize a new author associated with that book
      @author_params = params.require(:author).permit(:name, :popularity_score)
      @author_params[:name] = "#{@author_params[:first_name]} #{@author_params[:last_name]}" if @author_params[:first_name].present? && @author_params[:last_name].present? # Combine first_name and last_name into name
      @author_params.except!(:first_name, :last_name) # Remove first_name and last_name from author_params
      # Use strong parameters to whitelist the permitted attributes
      @author = @book.authors.build(@author_params)
    else
      # For standalone authors, just initialize a new Author object
      @author_params = params.require(:author).permit(:name, :popularity_score)
      @author_params[:name] = "#{@author_params[:first_name]} #{@author_params[:last_name]}" if @author_params[:first_name].present? && @author_params[:last_name].present? # Combine first_name and last_name into name
      @author_params.except!(:first_name, :last_name) # Remove first_name and last_name from author_params
      # Use strong parameters to whitelist the permitted attributes
      # Note: This assumes that the Author model has a 'name' attribute instead of 'first_name' and 'last_name'
      # Make sure to update the model and form accordingly if necessary
      # Initialize a new Author object with the modified author_params
      @author_params = @author_params.permit(:name, :popularity_score)
      @book = nil # Set @book to nil since it's not needed for standalone authors
      # Initialize a new Author object with the modified author_params
      @author_params = @author_params.permit(:name, :popularity_score)
      # Use strong parameters to whitelist the permitted attributes
      # Note: This assumes that the Author model has a 'name' attribute instead of 'first_name' and 'last_name'
      # Make sure to update the model and form accordingly if necessary
      @book = Book.find(params[:book_id]) if params[:book_id].present?
      # If author_params are present, initialize a new author with those params
      if @author_params.present?
        # If book is found, initialize a new author associated with that book
        if @book
          @book.authors.build(author_params)
        else
          # If book is not found, render new with errors
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: author.errors, status: :unprocessable_entity }
        end
      else
        # If author_params are not present, just initialize a new Author object
        @book = nil # Set @book to nil since it's not needed for standalone authors
        @book ||= Book.find_by(id: params[:book_id]) if params[:book_id].present?
        # Initialize a new Author object with the modified author_params
        @author_params = @author_params.permit(:name, :popularity_score)
        # Use strong parameters to whitelist the permitted attributes
        # Note: This assumes that the Author model has a 'name' attribute instead of 'first_name' and 'last_name'
        # Make sure to update the model and form accordingly if necessary
        @book = Book.find(params[:book_id]) if params[:book_id].present?
        # If book is found, initialize a new author associated with that book
        if @book
          @book.authors.build(@author_params)
        else
          # If book is not found, render new with errors
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: author.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  

  # GET /authors/1/edit
  def edit
    @author = Author.find(params[:id])
  end

  # POST /books/:book_id/authors or /authors.json
  def create
    @author_params = @author_params.merge(book_id: params[:book_id]) if @book
    @book = Book.find(params[:book_id]) if params[:book_id].present?
  
    respond_to do |format|
      if @book && author_params.present?
        # If nested under a book and author_params are present, create a new author associated with that book
        @author = @book.authors.new(@author_params)
      else
        # For standalone authors or if author_params are not present, just initialize a new Author object
        @author_params.delete(:book_id) if @author_params.present? # Remove book_id if present in author_params
        @author_params = params.require(:author).permit(:name, :popularity_score)     

        @book = nil # Set @book to nil since it's not needed for standalone authors
        @book ||= Book.find_by(id: params[:book_id]) if params[:book_id].present?
        # Initialize a new Author object with the modified author_params
        @author_params = @author_params.permit(:name, :popularity_score)
        # Use strong parameters to whitelist the permitted attributes
        # Note: This assumes that the Author model has a 'name' attribute instead of 'first_name' and 'last_name'
        # Make sure to update the model and form accordingly if necessary
        if @author_params.present?
          # If author_params are present, create a new author
          @book = nil # Set @book to nil since it's not needed for standalone authors
          @book ||= Book.find_by(id: params[:book_id]) if params[:book_id].present?
          # Initialize a new Author object with the modified author_params
          @author_params = @author_params.permit(:name, :popularity_score)
          # Use strong parameters to whitelist the permitted attributes
          # Note: This assumes that the Author model has a 'name' attribute instead of 'first_name' and 'last_name'
          # Make sure to update the model and form accordingly if necessary
          @book = Book.find(params[:book_id]) if params[:book_id].present?
          if @book
            @book.authors.create(author_params)
            format.html { redirect_to book_authors_path(@book), notice: "Author was successfully created." }
            format.json { render :show, status: :created, location: author }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: author.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to author_url(@author), notice: "Author was successfully updated." }
        format.json { render :show, status: :ok, location: author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1 or /authors/1.json
  def destroy
    @author.destroy

    respond_to do |format|
      format.html { redirect_to authors_url, notice: "Author was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_author
    if params[:id].present?
      @author =
        if @book
          @book.authors.find(params[:id])
        else
          Author.find(params[:id])
        end
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
