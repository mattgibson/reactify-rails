const webpack = require('webpack');
const path = require('path');

const config = {
  entry: [
    './webpack/client_renderer',
  ],
  resolve: {
    modules: ['node_modules', 'webpack'],
    extensions: ['.js', '.jsx', '.css'],
  },
  output: {
    filename: 'reactify_bundle.js',
    path: path.join(__dirname, '..', 'public', 'webpack'),
    publicPath: '/webpack/',
  },
  module: {
    rules: [
      {
        test: /\.(ttf|eot|svg|gif)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader',
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader',
        options: {
          limit: 10000,
          mimetype: 'application/font-woff',
        },
      },
    ],
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        API_ENDPOINT: `"${process.env.API_ENDPOINT}"`,
        NODE_ENV: `"${process.env.NODE_ENV}"`,
      },
    }),
  ],
};

module.exports = config;
