// This file gets processed only on the client. It should produce the exact same
// markup as the server render.

import React                     from 'react';
import { AppContainer }          from 'react-hot-loader';
import { render }                from 'react-dom';
import { Provider }              from 'react-redux';
import App                       from './components/app';
import storeCreator              from './redux/store';

const rootElement = document.getElementById('reactify-app');

const store = storeCreator();
const dispatch = store.dispatch;

__webpack_public_path__ = 'http://localhost:8080/webpack/';

dispatch({
  type: 'LOAD_HELLO_WORLD',
  data: window.__CONTROLLER_VARIABLES__,
});

const renderWithWrapper = (Component) => {
  render(
    <AppContainer>
      <Provider store={store}>
        <Component />
      </Provider>
    </AppContainer>,
    rootElement
  );
};

renderWithWrapper(App);

if (module.hot) {
  module.hot.accept('./components/app', () => {
    renderWithWrapper(App);
  });
}
