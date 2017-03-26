import React                         from 'react';
import { Provider }                  from 'react-redux';
import { renderToString }            from 'react-dom/server';
import { AppContainer }              from 'react-hot-loader';
import App                           from './components/app';
import storeCreator                  from './redux/store';

module.exports = function (jsonData) {
  // Get empty store
  const store = storeCreator();
  const dispatch = store.dispatch;

  dispatch({ type: 'LOAD_HELLO_WORLD', data: jsonData });

  // Get action names we want

  // Fire actions with the incoming data so that the store ia built

  return renderToString(
    <AppContainer>
      <Provider store={store}>
        <App />
      </Provider>
    </AppContainer>
  );
};
