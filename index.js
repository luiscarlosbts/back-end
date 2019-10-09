'use strict'

require('./loadenv');
require('./config/db');

const bodyParser = require('body-parser');
const express = require('express');
const log4js = require('log4js');
const apiApp = require('./config/api.js');
const config = require('./config/constants');
const logger = log4js.getLogger('index.js');

const app = express();
const router = express.Router();

logger.level = 'debug';
app.use(router);
app.use(bodyParser.urlencoded({ extended: false }));

// access-control-allow
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'POST, GET, PUT, DELETE');
  res.header('Access-Control-Allow-Headers',
  `Origin, X-Requested-With, Content-Type, Accept, Authorization`);
  res.url = req.url;
  next();
});

app.use(bodyParser.json({ limit: '25MB' }));
app.use('/api', apiApp);

app.listen(config.APP_PORT, () => {
  logger.info(`Listen on port ${config.APP_PORT} in ${config.ENV} environment`);
});