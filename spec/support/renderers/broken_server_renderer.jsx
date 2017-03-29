import React                         from 'react';
import { renderToString }            from 'react-dom/server';

const VariableRow = (props) => {
  return (
    <span>
      ${`${props.theKey}:${props.theValue}`}
    </span>
  );
};

module.exports = function (jsonData = '') {
  return renderToString(
    Syntax error!
    <div>
      <h1>
        Hello world!
      </h1>
      <p>
        ${Object.keys(jsonData).map((prop) => {
          return <VariableRow key={prop} theKey={prop} theValue={jsonData[prop]} />;
        })}
      </p>
    </div>
  );
};
