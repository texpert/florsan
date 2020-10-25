const { environment } = require('@rails/webpacker');
const erb = require('./loaders/erb');
const coffee =  require('./loaders/coffee');

environment.loaders.prepend('coffee', coffee);
environment.loaders.prepend('erb', erb);
module.exports = environment;
