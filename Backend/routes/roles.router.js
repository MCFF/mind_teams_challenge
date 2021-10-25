const express = require("express");
const RolesService = require("../services/role.service");
const validatorHandler = require("./../middlewares/validator.handler");
const {
  getRoleSchema,
  createRoleSchema,
  updateRoleSchema,
} = require("./../schemas/role.schema");
const passport = require("passport");
const { checkRoles } = require("../middlewares/auth.handler");

const router = express.Router();
const service = new RolesService();

router.get(
  "/",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  async (req, res, next) => {
    try {
      const roles = await service.all();
      res.json(roles);
    } catch (error) {
      next(error);
    }
  }
);

router.post(
  "/",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Admin"),
  validatorHandler(createRoleSchema, "body"),
  async (req, res, next) => {
    try {
      const role = req.body;
      const roleCreated = await service.create(role);

      res.status(201).json(roleCreated);
    } catch (error) {
      next(error);
    }
  }
);

module.exports = router;
