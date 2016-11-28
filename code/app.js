const express = require('express');
const coc = require('route-coc');
const log = require('t-log');

const app = express();
const stage = coc(app);

const port = 8080;
app.listen(port, () => {
  const startInfo = `server run at http:\/\/localhost:${port}`;

  log.info(startInfo);
});
