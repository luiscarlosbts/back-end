"use strict";

const apiApp = require('express')();

// define the module from the routers folder
const routes = require('../routers/routes');

// define which router will be used for an specific route
apiApp.use('/api', routes);

module.exports = apiApp;