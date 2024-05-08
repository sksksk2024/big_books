class TopAuthorsController < ApplicationController
  before_action :check_user_signed_in, only: [:index]

  def index
    current_month = Date.current.month
  
    # Fetch all authors
    @authors = Author.all
  
    if @authors.present?
      # Initialize the array with all authors and set book_count_in_may to 0
      @authors_with_book_counts_in_may = @authors.map do |author|
        {
          "id" => author.id,
          "name" => author.name,
          "book_count_in_may" => 0
        }
      end
  
      # Update book_count_in_may for authors who have written books in May
      @authors.each_with_index do |author, index|
        @authors_with_book_counts_in_may[index]["book_count_in_may"] = author.books.where("strftime('%m', books.publication_date) = ?", "%02d" % current_month).count
      end
  
      # Sort authors by the number of books written in May
      @authors_sorted_by_books_in_may = @authors_with_book_counts_in_may.sort_by { |author| -author["book_count_in_may"] }


    else
      # Handle the case where no authors are found
      flash.now[:alert] = "No authors found."
    end
  end
  
  
  

  private

  def check_user_signed_in
    unless user_signed_in?
      # Redirect the user to the sign-in page
      redirect_to new_user_session_path
    end
  end
end
