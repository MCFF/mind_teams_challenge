const boom = require("@hapi/boom");
const { models } = require("./../libs/sequelize");
const bcrypt = require("bcrypt");

class TeamsService {
  constructor() {}

  async all() {
    const teams = await models.Team.findAll();

    if (!teams == null) {
      throw boom.notFound();
    }
    return teams;
  }

  async find(id) {
    const team = await models.Team.findByPk(id);

    if (!team == null) {
      return boom.notFound();
    }
    return team;
  }

  async create(teamData) {
    const team = await models.Team.create(teamData);
    return team;
  }
}

module.exports = TeamsService;
