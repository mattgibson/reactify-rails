// We want to keep this running as a server in a subprocess so that it's ready
// to render on demand every time a new state is fed in via stdin.

// This means that all files loaded by require() will be interpreted by Babel.
// Not the contents of the file we are in, though.

var argv = require('minimist')(process.argv.slice(2));
var renderer_file = argv.renderer;
var delimiter = argv.delimiter;

require('babel-register')({
  presets: [
    'latest',
    'react',
  ],
  ignore: [
    '**/node_modules/*',
  ],
  plugins: [
    'react-hot-loader/babel',
    'transform-decorators-legacy',
  ],
});

const renderFunction = require(renderer_file);

process.stdin.resume();
process.stdin.setEncoding('utf8');

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

let theInput = '';

rl.on('line', (line) => {
  if (line.match(`${delimiter}`)) {
    console.log(renderFunction(JSON.parse(theInput)));
    console.log(delimiter);
    theInput = '';
  } else {
    theInput += line;
  }
});
