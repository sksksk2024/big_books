// config/webpack/environment.js
const { environment } = require('@rails/webpacker');
const { merge } = require('webpack-merge');

module.exports = merge(environment, {
  // Your additional configurations here
});