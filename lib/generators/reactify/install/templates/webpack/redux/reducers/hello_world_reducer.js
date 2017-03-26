import Immutable                   from 'seamless-immutable';

const defaultState = Immutable({});

export default function merchantDeliveriesReducer(state = defaultState, action) {
  switch (action.type) {
    case 'LOAD_HELLO_WORLD':
      for (var key in action.data) {
        if (action.data.hasOwnProperty(key)) {
          state = state.set(key, action.data[key]);
        }
      }
    default:
      return state;
  }
}
