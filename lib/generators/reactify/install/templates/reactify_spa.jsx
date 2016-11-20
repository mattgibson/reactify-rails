import { render }               from 'react-dom';
import HelloWorld               from './components/hello-world';
import React                    from 'react';
import store                    from './store';
import { Provider }             from 'react-redux';

const rootElement = document.getElementById('reactify-app');

render(
  <Provider store={store}>
    <HelloWorld />
  </Provider>,
  rootElement
);

