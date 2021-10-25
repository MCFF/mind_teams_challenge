const express = require("express");
const UsersService = require("./../services/user.service");
const validatorHandler = require("./../middlewares/validator.handler");
const {
  getUserSchema,
  createUserSchema,
  updateUserSchema,
  deleteUserSchema,
} = require("./../schemas/user.schema");
const passport = require("passport");
const { checkRoles } = require("../middlewares/auth.handler");

const router = express.Router();
const service = new UsersService();

router.get("/", async (req, res, next) => {
  try {
    const users = await service.all();
    res.json(users);
  } catch (error) {
    next(error);
  }
});

router.get(
  "/:id",
  validatorHandler(getUserSchema, "params"),
  async (req, res, next) => {
    try {
      const { id } = req.params;
      const user = await service.find(id);
      res.json(user);
    } catch (error) {
      next(error);
    }
  }
);

router.post(
  "/",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  validatorHandler(createUserSchema, "body"),
  async (req, res, next) => {
    try {
      const user = req.body;
      const userCreated = await service.create(user);

      res.status(201).json(userCreated);
    } catch (error) {
      next(error);
    }
  }
);

router.put(
  "/:id",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  validatorHandler(updateUserSchema, "body"),
  async (req, res, next) => {
    try {
      const { id } = req.params;

      const newUserData = req.body;
      const newUser = await service.update(id, newUserData);
      res.json(newUser);
    } catch (error) {
      next(error);
    }
  }
);

router.delete(
  "/:id",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  validatorHandler(deleteUserSchema, "params"),
  (req, res) => {
    const { id } = req.params;

    const userDeleted = service.delete(id);
    res.json(userDeleted);
  }
);

module.exports = router;
