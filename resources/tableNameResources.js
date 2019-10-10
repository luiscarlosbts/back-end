'use strict';

//const createError = require('http-errors');
const tableNameService = require('../services/tableNameService');
const log4js = require('log4js');
const logger = log4js.getLogger('Resource getUser.js');
logger.level = 'debug';

/**
* getRecords resource
* use the getRecords service to get all records from the table 'tabla' from the database
* @param {Object} req - client request that contains token
* @param {Object} res - client response in case toke is invalid or expired
* @return {object} a JSON response with database records or an error response
**/
async function getRecords(req, res) {
  logger.debug('getUsers resource');
  res.set('Content-Type', 'application/json');
  try {
    // get the records from the database
    const result = await tableNameService.getRecords();
    logger.debug('sending the records from the getRecords resource ');
    res.send({data: result, status: 'success', message: 'records found'});
  } catch (error) {
    logger.debug('sending the error trying to get the', error);
    res.status(404);
    res.send({ status: 'error', message: 'Records not found' });
  }
}

/**
* getRecordById resource
* use the getRecordById service to get the record from the table 'tabla' from the database with certain id
* @param {Object} req - client request that contains token
* @param {Object} res - client response in case toke is invalid or expired
* @return {object} a JSON response with database records or an error response
**/
async function getRecordById(req, res) {
  logger.debug('getUsers resource');
  res.set('Content-Type', 'application/json');
  try {
    // get the records from the database
    const result = await tableNameService.getRecordById(req.params.id);
    logger.debug('sending the records from the getRecords resource ');
    res.send({data: result, status: 'success', message: 'records found'});
  } catch (error) {
    logger.debug('sending the error trying to get the', error);
    res.status(400);
    res.send({ status: 'error', message: 'Records not found' });
  }
}

module.exports = {getRecords,getRecordById}