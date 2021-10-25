const { User, UserSchema } = require("./user.model");
const { Role, RoleSchema } = require("./role.model");
const { Team, TeamSchema } = require("./team.model");
const { LogTeam, LogTeamSchema } = require("./logTeam.model");
const { Account, AccountSchema } = require("./account.model");

function setupModels(sequelize) {
  User.init(UserSchema, User.config(sequelize));
  Role.init(RoleSchema, Role.config(sequelize));
  Team.init(TeamSchema, Team.config(sequelize));
  LogTeam.init(LogTeamSchema, LogTeam.config(sequelize));
  Account.init(AccountSchema, Account.config(sequelize));

  User.associate(sequelize.models);
  Role.associate(sequelize.models);
  Team.associate(sequelize.models);
  LogTeam.associate(sequelize.models);
  Account.associate(sequelize.models);
}

module.exports = setupModels;
