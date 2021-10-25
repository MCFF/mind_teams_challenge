const { Model, DataTypes, Sequelize } = require("sequelize");
const { TEAM_TABLE } = require("./team.model");

const ACCOUNT_TABLE = "accounts";
const AccountSchema = {
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
  clientName: {
    allowNull: false,
    type: DataTypes.STRING,
    field: "client_name",
  },
  devOpsName: {
    allowNull: false,
    type: DataTypes.STRING,
    field: "devops_name",
  },
  teamId: {
    field: "team_id",
    allowNull: true,
    type: DataTypes.INTEGER,
    references: {
      model: TEAM_TABLE,
      key: "id",
    },
    onUpdate: "CASCADE",
    onDelete: "SET NULL",
  },
};

class Account extends Model {
  static associate(models) {
    this.belongsTo(models.Team, { as: "team" });
  }
  static config(sequelize) {
    return {
      sequelize,
      tableName: ACCOUNT_TABLE,
      modelName: "Account",
      timestamps: false,
    };
  }
}

module.exports = { ACCOUNT_TABLE, AccountSchema, Account, Sequelize };
