import Immutable                   from 'seamless-immutable';

const defaultState = Immutable({});

export default function merchantDeliveriesReducer(state = defaultState, action) {
  switch (action.type) {
    default:
      return state;
  }
}
