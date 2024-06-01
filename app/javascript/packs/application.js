import "channels" // This line is correct if you are using ActionCable

// Import Rails specific modules
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels"; // Ensure this imports your channels

Rails.start();
Turbolinks.start();
ActiveStorage.start();

// Import your styles if needed
import "stylesheets/application";

// Add console.log statements for debugging
console.log('Rails has started');
console.log('Turbolinks has started');
console.log('ActiveStorage has started');

// Example of a function with console.log
function greet() {
    console.log('Hello from greet function!');
}

greet();