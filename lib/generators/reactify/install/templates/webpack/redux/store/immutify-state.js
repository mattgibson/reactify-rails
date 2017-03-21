import assign           from 'object-assign';
import Immutable        from 'seamless-immutable';

Object.assign = Object.assign || assign;

// Abstraction to handle pre-composed state received from server
// (ie, leave top level keys untouched)
export default function immutifyState(obj) {
  // Duplicate the object
  const objMut = Object.assign({}, obj);

  Object
    .keys(objMut)
    .forEach((key) => {
      if (key === 'router') {
        // stuff from the redux-router state, which breaks if immutable.
        objMut[key] = objMut[key];
      } else {
        // Other stuff from the normal stores, which needs to be immutable to
        // be consistent.
        objMut[key] = Immutable(objMut[key]);
      }
    });

  return objMut;
}
