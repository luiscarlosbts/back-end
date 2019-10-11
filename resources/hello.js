function hello(req, res) {
  res.set('Content-Type', 'application/json');
  res.send({
    status: 200,
    message: 'Hello',
    data: []
  });
}
module.exports = hello;