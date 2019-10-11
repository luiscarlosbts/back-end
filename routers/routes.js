'use strict';

// get router
const router = require('express').Router();

// get resource
const hello = require('../resources/hello');
router.get('/hello', hello);

module.exports = router;