const express = require('express');

const app = express();

app.get('/', (req, res) => {
  res.set('Content-Type', 'application/json');
  // res.send({message: "Hello"});
  res.send({
    status: 200,
    message: 'Success',
    data: [
      {
        id: 1,
        firstName: "Juanito",
        lastName: "Smith",
        age: 25,
        seniority_id: 2,
      }
    ]
  });
});

app.listen(3000,'127.0.0.1', () => {
  console.log('Server listen on port 3000')
})
// module.exports = {
//   sayHello : function () {
//     return 'Hello';
//   },
//   addNumber: (val1, val2) => {
//     return val1 + val2;
//   }
// }

module.exports = app;