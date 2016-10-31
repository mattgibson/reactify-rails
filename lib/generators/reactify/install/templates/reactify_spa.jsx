import { render }               from 'react-dom';
import HelloWorld               from './components/hello-world';
import React                    from 'react';

const rootElement = document.getElementById('reactify-app');

render(
  <HelloWorld />,
  rootElement
);

