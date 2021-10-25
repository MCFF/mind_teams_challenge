const boom = require("@hapi/boom");
const { models } = require("./../libs/sequelize");

class RolesService {
  constructor() {}

  async all() {
    const roles = await models.Role.findAll();
    if (roles == null) {
      throw boom.notFound();
    }
    return roles;
  }

  async create(data) {
    const newRole = await models.Role.create(data);
    return newRole;
  }
}

module.exports = RolesService;
