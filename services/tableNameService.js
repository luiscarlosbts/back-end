  
'use strict';

const tableNameDao = require('../daos/tableNameDao');
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
  return await tableNameDao()
}

module.exports = getRecords;