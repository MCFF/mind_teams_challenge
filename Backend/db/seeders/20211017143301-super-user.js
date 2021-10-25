"use strict";

const bcrypt = require("bcrypt");

module.exports = {
  up: async (queryInterface, Sequelize) => {
    const passwordHashed = await bcrypt.hash("test", 10);

    return queryInterface.bulkInsert("users", [
      {
        name: "Super user",
        email: "superuser@example.com",
        password: passwordHashed,
        english_level: 10,
        skills: "",
        cv: "",
        role_id: 1,
      },
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete("users", null, {});
  },
};
