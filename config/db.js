"use strict";
const  {Pool}  = require('pg')
const config = require('./constants');

const pool  = new Pool({
  host: config.DB_HOST,
  user: config.DB_USER,
  password: config.DB_PASSWORD,
  database: config.DB_NAME,
  port: config.DB_PORT
});
console.log(pool)

module.exports = pool;