const express = require("express");
const usersRouter = require("./users.router");
const accountsRouter = require("./accounts.router");

function routerApi(app) {
  const router = express.Router();

  app.use("/api/v1", router);

  router.use("/users", usersRouter);
  router.use("/accounts", accountsRouter);
}

module.exports = routerApi;
