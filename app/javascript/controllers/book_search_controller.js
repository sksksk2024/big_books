import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["searchInput", "results"];

  search(event) {
    event.preventDefault();
    // Perform search logic
  }
}