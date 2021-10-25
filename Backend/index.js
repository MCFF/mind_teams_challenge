const express = require("express");
const routerApi = require("./routes");
const {
  errorHandler,
  defaultErrorHandler,
} = require("./middlewares/error.handler");
const config = require("./config/config");
const { checkApiKey } = require("./middlewares/auth.handler");
require("./utils/auth");
const passport = require("passport");

const app = express();

app.use(express.json());
app.use(passport.initialize());

routerApi(app);

app.use(errorHandler);

app.listen(config.port);
