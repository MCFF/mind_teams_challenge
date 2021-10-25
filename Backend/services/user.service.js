const boom = require("@hapi/boom");
const { models } = require("./../libs/sequelize");
const bcrypt = require("bcrypt");
const RolesService = require("./role.service");

const roleService = new RolesService();

class UsersService {
  constructor() {
    this.users = [];
  }

  async all() {
    const users = await models.User.findAll({
      include: ["role"],
    });

    if (users == null) {
      throw boom.notFound();
    }
    return users;
  }

  async find(id) {
    const users = await models.User.findByPk(id, {
      include: ["role"],
    });
    if (users == null) {
      throw boom.notFound();
    }
    return users;
  }

  async findByEmail(email) {
    const users = await models.User.findOne({
      where: { email },
      include: ["role"],
    });
    return users;
  }

  async create(userData) {
    const passwordHashed = await bcrypt.hash(userData.password, 10);
    const newUser = await models.User.create({
      ...userData,
      password: passwordHashed,
    });

    const role = await models.Role.findByPk(userData.roleId);

    newUser.dataValues.role = role;

    delete newUser.dataValues.password;

    return newUser;
  }

  async update(id, userChanges) {
    const user = await this.find(id);
    const newUser = await user.update(userChanges);

    return newUser;
  }

  async delete(id) {
    const user = await this.find(id);
    user.destroy();
    return { id };
  }
}

module.exports = UsersService;
