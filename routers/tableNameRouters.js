'use strict';

// get router
const tableNameRouter = require('express').Router();

// get resource
const tableName = require('../resources/tableNameResources');

tableNameRouter.get('/' ,tableName.getRecords);
tableNameRouter.get('/:id' ,tableName.getRecordById);

module.exports = tableNameRouter;