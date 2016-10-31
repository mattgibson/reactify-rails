var webpack = require('webpack');
var assign = require('object-assign');
var baseConfig = require('./webpack.base.config.js');

Object.assign = assign;

var config = Object.assign(baseConfig, {
  devtool: 'inline-source-map',
});

config.entry.unshift('webpack-hot-middleware/client');
config.entry.unshift('react-hot-loader/patch');
// Hot reloading of the react stuff

// Keep this in sync with webpack.prod.config.js
config.module.loaders.push({
  test: /\.jsx?$/,
  exclude: /node_modules/,
  loader: 'babel-loader',
  query: {
    presets: ['latest', 'react'],
    plugins: [
      'transform-decorators-legacy',
    ],
  },
});

// Add the CSS/SCSS to the JS bundle so it will hot reload too.
config.module.loaders.push({
  test: /\.css$/,
  loaders: ['style-loader', 'css-loader'],
});
config.module.loaders.push({
  test: /\.scss$/,
  loaders: ['style', 'css', 'sass'],
});

config.plugins.push(new webpack.optimize.OccurenceOrderPlugin());
config.plugins.push(new webpack.HotModuleReplacementPlugin());
config.plugins.push(new webpack.NoErrorsPlugin());

module.exports = config;
