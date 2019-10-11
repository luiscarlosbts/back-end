  
'use strict';

const tableNameDao = require('../daos/endpointDao');
const log4js = require('log4js');
const logger = log4js.getLogger('Service getUser.js');
logger.level = 'debug';

/**
* getRecords service
* use the tableNameDao to get all records from the table 'tabla' from the database
* @return {object} the database records gotten or an error
**/
async function getRecords() {
  logger.debug('get records service');
  return await tableNameDao.getRecords()
}

/**
* getRecordById service
* use the tableNameDao to get the selected record from the table 'tabla' from the database
* @param {id} id 
* @return {object} database record
**/
async function getRecordById(id) {
  logger.debug('get records service');
  return await tableNameDao.getRecordById(id)
}

module.exports = {getRecords,getRecordById};