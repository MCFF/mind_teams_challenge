const { Model, DataTypes, Sequelize } = require("sequelize");
const { ROLE_TABLE } = require("./role.model");

const USER_TABLE = "users";
const UserSchema = {
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
  email: {
    allowNull: false,
    type: DataTypes.STRING,
    unique: true,
  },
  password: {
    allowNull: false,
    type: DataTypes.STRING,
  },
  englishLevel: {
    allowNull: false,
    type: DataTypes.INTEGER,
    field: "english_level",
    defaultValue: 0,
  },
  skills: {
    allowNull: false,
    type: DataTypes.TEXT,
  },
  cv: {
    allowNull: false,
    type: DataTypes.STRING,
  },
  roleId: {
    field: "role_id",
    allowNull: false,
    type: DataTypes.INTEGER,
    defaultValue: 3,
    references: {
      model: ROLE_TABLE,
      key: "id",
    },
    onUpdate: "CASCADE",
    onDelete: "SET DEFAULT",
  },
};

class User extends Model {
  static associate(models) {
    this.belongsTo(models.Role, { as: "role" });
    this.hasMany(models.LogTeam, {
      as: "log",
      foreignKey: "userId",
    });
  }
  static config(sequelize) {
    return {
      sequelize,
      tableName: USER_TABLE,
      modelName: "User",
      timestamps: false,
    };
  }
}

module.exports = { USER_TABLE, UserSchema, User };
