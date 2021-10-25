"use strict";

const { RoleSchema, ROLE_TABLE } = require("./../models/role.model");

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable(ROLE_TABLE, RoleSchema);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable(ROLE_TABLE);
  },
};
