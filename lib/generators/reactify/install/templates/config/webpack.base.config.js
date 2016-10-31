var webpack = require('webpack');
var path = require('path');

const config = {
  entry: [
    './webpack/reactify_spa',
  ],
  resolve: {
    modulesDirectories: ['node_modules', 'shared'],
    extensions: ['', '.js', '.jsx', '.css'],
  },
  output: {
    filename: 'reactify_spa.js',
    path: path.join(__dirname, '..', 'public', 'webpack'),
    publicPath: '/webpack/',
  },
  module: {
    loaders: [
      {
        test: /\.(ttf|eot|svg|gif)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader',
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?limit=10000&mimetype=application/font-woff',
      },
    ],
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        API_ENDPOINT: '"' + process.env.API_ENDPOINT + '"',
        NODE_ENV: '"' + process.env.NODE_ENV + '"',
      },
    }),
  ],
};

module.exports = config;
