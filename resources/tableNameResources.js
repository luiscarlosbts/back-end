'use strict';

//const createError = require('http-errors');
const tableNameService = require('../services/tableNameService');
const log4js = require('log4js');
const logger = log4js.getLogger('Resource getUser.js');
logger.level = 'debug';

/**
* getUsers resource
* use the getUsers service to get all users from the database
* @param {Object} req - client request that contains token
* @param {Object} res - client response in case toke is invalid or expired
* @return {object} a JSON response with database records or an error response
**/
async function getRecords(req, res) {
  logger.debug('getUsers resource');
  res.set('Content-Type', 'application/json');
  try {
    // get the users from the database
    const result = await tableNameService();
    logger.debug('sending the users from the getUsers resource '+result);
    res.send({data: {result}, status: 'success', message: 'Users found'});
  } catch (error) {
    logger.debug('sending the error trying to get the', error);
    res.status(404);
    res.send({ status: 'error', message: 'Users not found' });
  }
}

module.exports = getRecords