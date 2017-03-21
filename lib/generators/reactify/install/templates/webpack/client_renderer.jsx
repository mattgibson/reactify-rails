// This file gets processed only on the client. It should produce the exact same
// markup as the server render.

import { render }                from 'react-dom';
import { Provider }              from 'react-redux';
import { default as HelloWorld } from './components/hello-world';
import React                     from 'react';
import store                     from './redux/store';

const rootElement = document.getElementById('reactify-app');

render(
  <Provider store={store(window.__CONTROLLER_VARIABLES__)}>
    <HelloWorld />
  </Provider>,
  rootElement
);

