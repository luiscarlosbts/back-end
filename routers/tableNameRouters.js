'use strict';

// get router
const tableNameRouter = require('express').Router();

// get resource
const tableName = require('../resources/tableNameResources');

tableNameRouter.get('/' ,tableName);

module.exports = tableNameRouter;