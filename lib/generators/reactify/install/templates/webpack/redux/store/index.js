import {
  createStore,
  combineReducers,
}                               from 'redux';
import * as reducers            from '../reducers';
import immutifyState            from './immutify-state';

export default function (state) {
  const reducer = combineReducers(reducers);

  const initialState = immutifyState(state);
  return createStore(reducer, initialState);
}
