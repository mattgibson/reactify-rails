const webpack = require('webpack');
const assign = require('object-assign');
const baseConfig = require('./webpack.base.config.js');
const path = require('path');

Object.assign = assign;

const config = Object.assign(baseConfig, {
  devtool: 'inline-source-map',
});

// Hot reloading of the react stuff
config.entry.unshift('webpack/hot/only-dev-server');
config.entry.unshift('webpack-dev-server/client?http://localhost:8080');
config.entry.unshift('react-hot-loader/patch');

// Keep this in sync with webpack.prod.config.js
config.module.rules.push({
  test: /\.jsx?$/,
  exclude: /node_modules/,
  loader: 'babel-loader',
  options: {
    babelrc: false,
    presets: [
      [
        'latest',
        {
          es2015: {
            modules: false,
          },
          es2016: {
            modules: false,
          },
          es2017: {
            modules: false,
          },
        },
      ],
      'react',
    ],
    plugins: [
      'react-hot-loader/babel',
      'transform-decorators-legacy',
    ],
  },
});

// Add the CSS/SCSS to the JS bundle so it will hot reload too.
config.module.rules.push({
  test: /\.css$/,
  use: ['style-loader', 'css-loader'],
});
config.module.rules.push({
  test: /\.scss$/,
  use: ['style-loader', 'css-loader', 'sass-loader'],
});
config.devServer = {
  hot: true,
  inline: false,
  stats: { colors: true },
  contentBase: path.join(__dirname, '..', 'public', 'reactify'),
  publicPath: '/reactify/',
};

config.plugins.push(new webpack.HotModuleReplacementPlugin());
config.plugins.push(new webpack.NamedModulesPlugin());
config.plugins.push(new webpack.NoEmitOnErrorsPlugin());

module.exports = config;
