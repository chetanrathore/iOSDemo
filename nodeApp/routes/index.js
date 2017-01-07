const express = require('express');
const routes = express.Router();

routes.use('/api/', require('./category'));

module.exports = routes;
