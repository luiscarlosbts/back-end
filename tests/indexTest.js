const chai = require('chai');
const assert = require('chai').assert;
const chaiHttp = require('chai-http');
const should = chai.should();
const app = require('../index');
chai.use(chaiHttp);

describe('Request to DB', function () {
  // response has the right status code and is object
  it('should response type object', function (done) {
    chai.request(app)
      .get('/')
      .end((err, res) => {
        console.log(err)
        res.should.have.status(200);
        res.body.should.be.an('object');
        done();
      })
  });
  // Test to know if the response body has the required properties
  it('should have properties status, message and data', function (done) {
    chai.request(app)
      .get('/')
      .end((err, res) => {
        res.body.should.have.property('status');
        res.body.should.have.property('message');
        res.body.should.have.property('data');
        done();
      })
  });
  it('Response\'s data property should have an array', (done) => {
    chai.request(app)
      .get('/')
      .end((err, res) => {
    const result = res.body['data'];
        result.should.be.a('array');
        done();
      });
  });
  it('Data in position 0 should have user data', (done) => {
    const userDataExpected = {
      id: 1,
      firstName: "Juanito",
      lastName: "Smith",
      age: 25,
      seniority_id: 2,
    };
    chai.request(app)
      .get('/')
      .end((err, res) => {
    const result = res.body.data[0];
        result.should.be.eql(userDataExpected);
        done();
      })
  });
});
