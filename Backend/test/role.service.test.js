const RolesService = require("../services/role.service");
const service = new RolesService();

describe("Roles services tests", () => {
  describe("testing function 'all'", () => {
    test("should contain id, role", async () => {
      const roles = await service.all();

      roles.forEach((role) => {
        expect(role).toMatchObject({
          id: expect.any(Number),
          role: expect.any(String),
        });
      });
    });
  });

  describe("testing function 'create'", () => {
    test("should contain id, role", async () => {
      const role = await service.create({
        role: "Test role",
      });

      expect(role).toMatchObject({
        id: expect.any(Number),
        role: expect.any(String),
      });
      expect(role.role).toBe("Test role");
    });
  });
});
