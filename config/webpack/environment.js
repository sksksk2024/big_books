const { environment } = require('@rails/webpacker');
const { resolve } = require('path');
const webpack = require('webpack');

environment.loaders.append('babel', {
  test: /\.js$/,
  exclude: /node_modules/,
  use: {
    loader: 'babel-loader',
    options: {
      presets: ['@babel/preset-env']
    }
  }
});

module.exports = environment;
