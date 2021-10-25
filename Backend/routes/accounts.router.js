const express = require("express");
const AccountService = require("../services/account.service");
const validatorHandler = require("./../middlewares/validator.handler");
const {
  getAccountSchema,
  createAccountSchema,
} = require("./../schemas/account.schema");
const passport = require("passport");
const { checkRoles } = require("../middlewares/auth.handler");

const router = express.Router();
const service = new AccountService();

router.get(
  "/",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  async (req, res, next) => {
    try {
      const accounts = await service.all();

      res.json(accounts);
    } catch (error) {
      next(error);
    }
  }
);

router.get(
  "/:id",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  validatorHandler(getAccountSchema, "params"),
  async (req, res, next) => {
    try {
      const { id } = req.params;

      const accounts = await service.find(id);
      res.json(accounts);
    } catch (error) {
      next(error);
    }
  }
);

router.post(
  "/",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  validatorHandler(createAccountSchema, "body"),
  async (req, res, next) => {
    try {
      const account = req.body;
      const newAccount = await service.create(account);

      res.status(201).json(newAccount);
    } catch (error) {
      next(error);
    }
  }
);

module.exports = router;
