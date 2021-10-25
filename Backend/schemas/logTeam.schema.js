const Joi = require("joi");

const id = Joi.number().id();
const userId = Joi.number().id();
const teamId = Joi.number().id();
const startDate = Joi.date();
const endDate = Joi.date();

const getLogSchema = Joi.object({
  id: userId.required(),
});

const createLogBodySchema = Joi.object({
  userId: userId.required(),
  startDate: startDate.required(),
  endDate: endDate.required(),
});

const createLogParamsSchema = Joi.object({
  id: teamId.required(),
});

module.exports = { getLogSchema, createLogBodySchema, createLogParamsSchema };
