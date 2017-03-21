import React                     from 'react';
import { Provider }              from 'react-redux';
import { renderToString }        from 'react-dom/server';
import { default as HelloWorld }            from './components/hello-world';
import store                     from './redux/store';

module.exports = function (state) {
  return renderToString(
    <Provider store={store(state)}>
      <HelloWorld />
    </Provider>
  );
};
