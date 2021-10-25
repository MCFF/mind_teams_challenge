const boom = require("@hapi/boom");
const { models } = require("./../libs/sequelize");
const { Op } = require("sequelize");
const bcrypt = require("bcrypt");
const UserService = require("./user.service");

const userService = new UserService();

class LogTeamsService {
  constructor() {}

  async all() {
    const logs = await models.LogTeam.findAll();
    if (!logs == null) {
      throw boom.notFound();
    }
    return logs;
  }

  async findByTeam(teamId) {
    const logs = await models.LogTeam.findAll({
      where: {
        teamId: teamId,
        startDate: {
          [Op.lte]: new Date(),
        },
        endDate: {
          [Op.gte]: new Date(),
        },
      },
      include: ["team", "user"],
    });
    if (!logs == null) {
      throw boom.notFound();
    }
    return logs;
  }

  async create(id, teammateData) {
    const logData = {
      ...teammateData,
      teamId: id,
    };
    const log = await models.LogTeam.create(logData);
    const user = await userService.find(log.userId);

    delete user.dataValues.password;

    return user;
  }
}

module.exports = LogTeamsService;
