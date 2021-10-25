const Joi = require("joi");

const id = Joi.number().id();
const name = Joi.string();

const getTeamSchema = Joi.object({
  id: id.required(),
});

const createTeamSchema = Joi.object({
  name: name.required(),
});

module.exports = { getTeamSchema, createTeamSchema };
