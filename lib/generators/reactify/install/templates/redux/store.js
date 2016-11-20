import {
  createStore,
  combineReducers,
}                               from 'redux';
import * as reducers            from 'reducers';
import immutifyState            from 'store/immutify-state';

const initialState = immutifyState(window.__CONTROLLER_VARIABLES__);
const reducer = combineReducers(reducers);

const store = createStore(reducer, initialState);

export default store;
