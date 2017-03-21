// We want to keep this running as a server in a subprocess so that it's ready
// to render on demand every time a new state is fed in via stdin.

// This means that all files loaded by require() will be interpreted by Babel.
// Not the contents of the file we are in, though.
require('babel-register')({
  "presets": [
    "latest",
    "react"
  ],
  "ignore": [
    "**/node_modules/*"
  ],
  "plugins": [
    "transform-decorators-legacy"
  ],
});

const renderFunction = require('./server_renderer.jsx');

process.stdin.resume();
process.stdin.setEncoding('utf8');

const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

let theInput = '';

rl.on('line', function (line) {
  if (line.match(/__END__/)) {
    console.log(renderFunction(theInput));
    console.log('__END__');
    theInput = '';
  } else {
    theInput += line;
  }
});
