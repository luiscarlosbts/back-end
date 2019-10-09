  
'use strict';

const tableNameDao = require('../daos/tableNameDao');
const log4js = require('log4js');
const logger = log4js.getLogger('Service getUser.js');
logger.level = 'debug';

/**
* getUsers service
* use the userDaos to get all users from the database
* @return {object} the database records gotten or an error
**/
async function getRecords() {
  logger.debug('get records service');
  return await tableNameDao()
}

module.exports = getRecords;