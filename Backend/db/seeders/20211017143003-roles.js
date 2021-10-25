"use strict";

module.exports = {
  up: async (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert("roles", [
      {
        role: "Super user",
      },
      {
        role: "Admin",
      },
      {
        role: "User",
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete("roles", null, {});
  },
};
