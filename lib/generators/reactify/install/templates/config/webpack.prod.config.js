const assign = require("object-assign");
Object.assign = assign;

var ExtractTextPlugin = require("extract-text-webpack-plugin");

var baseConfig = require("./webpack.base.config.js");

var config = Object.assign(baseConfig, {});

// No hot reload, just straight compiling.
// Keep this in sync with webpack.config.js and .babelrc
config.module.rules.push({
  test: /\.jsx?$/,
  exclude: /node_modules/,
  loader: "babel-loader",
  options: {
    presets: ["latest", "react"],
    plugins: ["transform-decorators-legacy"],
  }
});

// Extract all the sass and scss into a separate file.
config.plugins.push(new ExtractTextPlugin("styles.css"));
config.module.rules.push({
  test: /(\.scss|\.css)$/,
  use: ExtractTextPlugin.extract({
    fallback: 'style-loader',
    use: [
      'css-loader',
      'sass-loader',
    ],
  }),
});

module.exports = config;
