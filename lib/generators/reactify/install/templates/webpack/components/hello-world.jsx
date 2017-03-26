import React                            from 'react';
import { connect }                      from 'react-redux';

export class HelloWorld extends React.Component {
  render() {
    return (
      <div>
        <h1>
          Hello world!
        </h1>
        <p>
          Any instance variables you add to the controller action that you call
          will end up here:
        </p>
        <pre>
          {JSON.stringify(this.props.state, null, 2)}
        </pre>
      </div>
    );
  }
}

export default connect((state, ownProps) => ({
  state: state.helloWorld,
}))(HelloWorld);
