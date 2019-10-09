"use strict";

const apiApp = require('express')();

// define the module from the routers folder
const tableName = require('../routers/tableNameRouters');

// define which router will be used for an specific route
apiApp.use('/tableName', tableName);

module.exports = apiApp;