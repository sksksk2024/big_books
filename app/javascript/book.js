document.addEventListener("DOMContentLoaded", () => {
  const bookSearchInput = document.getElementById("book_search");

  if (bookSearchInput) {
    bookSearchInput.addEventListener("input", () => {
      const query = bookSearchInput.value.trim();

      fetch(`/books?q[book_name_cont]=${query}`, { headers: { "X-Requested-With": "XMLHttpRequest" }})
        .then(response => response.text())
        .then(data => {
          // Handle the response, for example, update the search results div
          document.getElementById("search_results").innerHTML = data;
        })
        .catch(error => {
          console.error("Error:", error);
        });
    });
  }
});