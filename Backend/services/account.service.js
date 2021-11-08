const boom = require("@hapi/boom");
const { models } = require("./../libs/sequelize");
const bcrypt = require("bcrypt");
const TeamService = require("./team.service");
const { Sequelize } = require("../db/models/account.model");

const teamService = new TeamService();

class AccountsService {
  constructor() {}

  async all() {
    let accounts = await models.Account.findAll({
      include: ["team"],
    });

    if (!accounts) {
      throw boom.notFound("Account not found");
    }
    return accounts;
  }

  async find(id) {
    const account = await models.Account.findByPk(id, {
      include: ["team"],
    });

    if (!account) {
      throw boom.notFound("Account not found");
    }
    return account;
  }

  async create(accountData) {
    const account = await models.Account.create(accountData);

    return account;
  }

  async delete(id) {
    const account = await models.Account.findByPk(id);
    account.destroy();
    return { id };
  }
}

module.exports = AccountsService;
