const { Model, DataTypes, Sequelize } = require("sequelize");

const TEAM_TABLE = "teams";
const TeamSchema = {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER,
  },
  name: {
    allowNull: false,
    type: DataTypes.STRING,
  },
};

class Team extends Model {
  static associate(models) {
    this.hasOne(models.Account, {
      as: "account",
      foreignKey: "teamId",
    });
    this.hasMany(models.LogTeam, {
      as: "log",
      foreignKey: "teamId",
    });
  }
  static config(sequelize) {
    return {
      sequelize,
      tableName: TEAM_TABLE,
      modelName: "Team",
      timestamps: false,
    };
  }
}

module.exports = { TEAM_TABLE, TeamSchema, Team };
