const { Model, DataTypes, Sequelize } = require("sequelize");
const { USER_TABLE } = require("./user.model");
const { TEAM_TABLE } = require("./team.model");

const LOG_TEAM_TABLE = "log_teams";
const LogTeamSchema = {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  userId: {
    field: "user_id",
    allowNull: false,
    type: DataTypes.INTEGER,
    defaultValue: 0,
    references: {
      model: USER_TABLE,
      key: "id",
    },
    onUpdate: "CASCADE",
    onDelete: "NO ACTION",
  },
  teamId: {
    field: "team_id",
    allowNull: false,
    type: DataTypes.INTEGER,
    defaultValue: 0,
    references: {
      model: TEAM_TABLE,
      key: "id",
    },
    onUpdate: "CASCADE",
    onDelete: "NO ACTION",
  },
  startDate: {
    allowNull: false,
    type: DataTypes.DATE,
    field: "start_date",
    defaultValue: Sequelize.NOW,
  },
  endDate: {
    allowNull: false,
    type: DataTypes.DATE,
    field: "end_date",
  },
};

class LogTeam extends Model {
  static associate(models) {
    this.belongsTo(models.User, { as: "user" });
    this.belongsTo(models.Team, { as: "team" });
  }
  static config(sequelize) {
    return {
      sequelize,
      tableName: LOG_TEAM_TABLE,
      modelName: "LogTeam",
      timestamps: false,
    };
  }
}

module.exports = { LOG_TEAM_TABLE, LogTeamSchema, LogTeam };
