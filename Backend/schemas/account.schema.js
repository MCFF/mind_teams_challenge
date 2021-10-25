const Joi = require("joi");

const id = Joi.number().id();
const name = Joi.string();
const clientName = Joi.string();
const devOpsName = Joi.string();
const teamId = Joi.number().id();

const getAccountSchema = Joi.object({
  id: id.required(),
});

const createAccountSchema = Joi.object({
  name: name.required(),
  clientName: clientName.required(),
  devOpsName: devOpsName.required(),
  teamId: teamId.required(),
});

module.exports = { getAccountSchema, createAccountSchema };
