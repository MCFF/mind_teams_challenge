const express = require("express");
const usersRouter = require("./users.router");
const authRouter = require("./auth.router");
const rolesRouter = require("./roles.router");
const teamsRouter = require("./teams.router");
const accountsRouter = require("./accounts.router");

function routerApi(app) {
  const router = express.Router();

  app.use("/api/v1", router);

  router.use("/users", usersRouter);
  router.use("/auth", authRouter);
  router.use("/roles", rolesRouter);
  router.use("/teams", teamsRouter);
  router.use("/accounts", accountsRouter);
}

module.exports = routerApi;
