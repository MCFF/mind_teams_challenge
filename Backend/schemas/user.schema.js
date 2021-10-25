const Joi = require("joi");

const id = Joi.number().id();
const name = Joi.string();
const email = Joi.string().email();
const password = Joi.string().alphanum();
const englishLevel = Joi.number().max(10);
const skills = Joi.string();
const cv = Joi.string();
const roleId = Joi.number().min(1).max(3);

const createUserSchema = Joi.object({
  name: name.required(),
  email: email.required(),
  password: password.required(),
  englishLevel: englishLevel.required(),
  skills: skills.required(),
  cv: cv.required(),
  roleId: roleId,
});

const updateUserSchema = Joi.object({
  name: name,
  email: email,
  password: password,
  englishLevel: englishLevel,
  skills: skills,
  cv: cv,
  roleId: roleId,
});

const getUserSchema = Joi.object({
  id: id.required(),
});
const deleteUserSchema = Joi.object({
  id: id.required(),
});

module.exports = {
  createUserSchema,
  updateUserSchema,
  getUserSchema,
  deleteUserSchema,
};
