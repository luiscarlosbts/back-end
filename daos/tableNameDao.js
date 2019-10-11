'use strict'

const pool = require('../config/db');

/**
* getRecords method
* get all records from the table 'tabla' from the database
* @return {object} database records
**/
async function getRecords() {
  return await new Promise((resolve, reject) => {
    pool.connect((err, client, release) => {
      if (err) {
        reject(err.stack)
      }
      client.query('SELECT * FROM tabla', (err, result) => {
        release()
        if (err) {
          reject(err.stack)
        }
        resolve(result.rows)
      })
    })
  })
}

/**
* getRecordById method
* get the record from the table 'tabla' from the database with the indicated id
* @return {object} database record
**/

/**
 * getRecordById method
 * get the record from the table 'tabla' from the database with the indicated id
 * @param {id} id 
 * @return {object} database record
 */
async function getRecordById(id) {
  return await new Promise((resolve, reject) => {
    pool.connect((err, client, release) => {
      if (err) {
        reject(err.stack)
      }
      client.query(`SELECT * FROM tabla WHERE id = ${id}`, (err, result) => {
        release()
        if (err) {
          reject(err.stack)
        }
        resolve(result.rows)
      })
    })
  })
}

module.exports = { getRecords, getRecordById }
