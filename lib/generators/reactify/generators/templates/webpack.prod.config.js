const assign = require("object-assign");
Object.assign = assign;

var ExtractTextPlugin = require("extract-text-webpack-plugin");

var baseConfig = require("./webpack.base.config.js");

var config = Object.assign(baseConfig, {});

// No hot reload, just straight compiling.
// Keep this in sync with webpack.config.js and .babelrc
config.module.loaders.push({
  test: /\.jsx?$/,
  exclude: /node_modules/,
  loader: "babel-loader",
  query: {
    presets: ["latest", "stage-0", "react"],
    plugins: ["transform-decorators-legacy"]
  }
});

// Extract all the sass and scss into a separate file.
config.plugins.push(new ExtractTextPlugin("styles.css"));
config.module.loaders.push({
  test: /(\.scss|\.css)$/,
  loader: ExtractTextPlugin.extract("style", "css?postcss!sass"),
});

module.exports = config;
