"use strict";

const {
  LogTeam,
  LOG_TEAM_TABLE,
  LogTeamSchema,
} = require("./../models/logTeam.model");

module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable(LOG_TEAM_TABLE, LogTeamSchema);
  },

  down: async (queryInterface, Sequelize) => {
    await queryInterface.dropTable(LOG_TEAM_TABLE);
  },
};
