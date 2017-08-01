const strider = require('strider');
const path = require('path');
const instance = strider(path.join(process.env.STRIDER_DIR, 'node_modules'), {}, (err, initialized, appInstance) => {
  console.log('Strider is now running!');
});
