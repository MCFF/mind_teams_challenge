const Joi = require("joi");

const id = Joi.number().id();
const role = Joi.string();

const createRoleSchema = Joi.object({
  role: role.required(),
});
const getRoleSchema = Joi.object({
  id: id,
});
const updateRoleSchema = Joi.object({
  id: id.required(),
  role: role.required(),
});
const deleteRoleSchema = Joi.object({
  id: id.required(),
});

module.exports = {
  createRoleSchema,
  getRoleSchema,
  updateRoleSchema,
  deleteRoleSchema,
};
