'use strict'

const pool = require('../config/db');

/**
* getRecords method
* get all records from the table 'tabla' from the database
* @return {object} database records
**/
async function getRecords() {
  return await new Promise((resolve, reject) => {
    pool.query('SELECT * FROM tabla', (err, res) => {
      pool.end()
      resolve(res.rows)
    })
  });
}

module.exports = getRecords
