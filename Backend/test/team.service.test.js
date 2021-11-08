const TeamsService = require("../services/team.service");
const service = new TeamsService();

describe("Teams services tests", () => {
  describe("testing function 'all'", () => {
    test("should return id, name", async () => {
      const teams = await service.all();

      teams.forEach((team) => {
        expect(team).toMatchObject({
          id: expect.any(Number),
          name: expect.any(String),
        });
      });
    });
  });

  describe("testing function 'find'", () => {
    test("should return id, name", async () => {
      const team = await service.find(1);

      expect(team).toMatchObject({
        id: expect.any(Number),
        name: expect.any(String),
      });
    });
  });

  describe("testing function 'find' with no existing id", () => {
    test("Should return not found error", async () => {
      const teams = await service.all();
      const lastId = teams[teams.length - 1].dataValues.id;
      await expect(service.find(lastId + 1)).rejects.toThrow("Not Found");
    });
  });

  describe("testing function 'create'", () => {
    test("should return id, name", async () => {
      const team = await service.create({
        name: "Test team",
      });
      expect(team).toMatchObject({
        id: expect.any(Number),
        name: expect.any(String),
      });
    });
  });
});
