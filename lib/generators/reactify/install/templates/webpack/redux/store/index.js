import {
  createStore,
  combineReducers,
}                               from 'redux';
import * as reducers            from '../reducers';
import Immutable                from 'seamless-immutable';

export default function () {
  const reducer = combineReducers(reducers);
  const initialState = Immutable({});

  return createStore(reducer, initialState);
}
