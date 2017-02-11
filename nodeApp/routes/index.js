const express = require('express');
const routes = express.Router();

routes.use('/api/', require('./category'));
routes.use('/api/', require('./product'));
routes.use('/api/', require('./user'));

module.exports = routes;
