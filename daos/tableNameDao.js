'use strict'

const pool = require('../config/db');

/**
* getUsers method
* get all users from the database
* @return {object} database records
**/
async function getRecords() {
  return await new Promise((resolve, reject) => {
    console.log('aqui entra')
    pool.connect((err, client, release) => {
      console.log('aqui no')
      if (err) {
        return console.error('Error acquiring client', err.stack)
      }
      client.query('SELECT NOW()', (err, result) => {
        release()
        if (err) {
          return console.error('Error executing query', err.stack)
        }
        console.log(result.rows)
        return result
      })
    })

    
  });
}

module.exports = getRecords
