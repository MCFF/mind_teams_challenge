"use strict";

const { AccountSchema, ACCOUNT_TABLE } = require("./../models/account.model");

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable(ACCOUNT_TABLE, AccountSchema);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable(ACCOUNT_TABLE);
  },
};
