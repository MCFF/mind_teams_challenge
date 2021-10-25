const express = require("express");
const TeamsService = require("../services/team.service");
const LogTeamService = require("../services/logTeam.service");
const validatorHandler = require("./../middlewares/validator.handler");
const { getTeamSchema, createTeamSchema } = require("../schemas/team.schema");
const {
  getLogSchema,
  createLogBodySchema,
  createLogParamsSchema,
} = require("../schemas/logTeam.schema");
const passport = require("passport");
const { checkRoles } = require("../middlewares/auth.handler");

const router = express.Router();
const service = new TeamsService();
const logService = new LogTeamService();

router.get(
  "/",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  async (req, res, next) => {
    try {
      const teams = await service.all();
      res.json(teams);
    } catch (error) {
      next(error);
    }
  }
);

router.get(
  "/members",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  async (req, res, next) => {
    try {
      const log = await logService.all();
      res.json(log);
    } catch (error) {
      next(error);
    }
  }
);

router.get(
  "/:id",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  validatorHandler(getTeamSchema, "params"),
  async (req, res, next) => {
    try {
      const { id } = req.params;

      const team = await service.find(id);
      res.json(team);
    } catch (error) {
      next(error);
    }
  }
);

router.get(
  "/:id/members",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  validatorHandler(getLogSchema, "params"),
  async (req, res, next) => {
    try {
      const { id } = req.params;
      const team = await logService.findByTeam(id);
      res.json(team);
    } catch (error) {
      next(error);
    }
  }
);

router.post(
  "/:id/members",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  validatorHandler(createLogParamsSchema, "params"),
  validatorHandler(createLogBodySchema, "body"),
  async (req, res, next) => {
    try {
      const { id } = req.params;
      const teammateData = req.body;
      const team = await logService.create(id, teammateData);
      res.json(team);
    } catch (error) {
      next(error);
    }
  }
);

router.post(
  "/",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  validatorHandler(createTeamSchema, "body"),
  async (req, res, next) => {
    try {
      const team = req.body;
      const newTeam = await service.create(team);

      res.status(201).json(newTeam);
    } catch (error) {
      next(error);
    }
  }
);

router.get(
  "/members",
  passport.authenticate("jwt", { session: false }),
  checkRoles("Super user", "Admin"),
  async (req, res, next) => {
    try {
      const log = await logService.all();
      res.json(log);
    } catch (error) {
      next(error);
    }
  }
);

module.exports = router;
