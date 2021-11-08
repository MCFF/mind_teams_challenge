const UsersService = require("../services/user.service");
const service = new UsersService();

describe("User services tests", () => {
  describe("testing function 'all'", () => {
    test("should contain id, name, email, englishLevel, skills, cv and role", async () => {
      const users = await service.all();
      users.forEach((user) => {
        expect(user).toMatchObject({
          id: expect.any(Number),
          name: expect.any(String),
          email: expect.any(String),
          englishLevel: expect.any(Number),
          skills: expect.any(String),
          cv: expect.any(String),
          roleId: expect.any(Number),
        });
      });
    });
  });
  describe("testing function 'find'", () => {
    test("should contain id, name, email, englishLevel, skills, cv and role", async () => {
      const user = await service.find(1);

      expect(user).toMatchObject({
        id: expect.any(Number),
        name: expect.any(String),
        email: expect.any(String),
        englishLevel: expect.any(Number),
        skills: expect.any(String),
        cv: expect.any(String),
        roleId: expect.any(Number),
      });
    });
  });

  describe("testing function 'find' with no existing id", () => {
    test("Should return not found error", async () => {
      const users = await service.all();
      const lastId = users[users.length - 1].dataValues.id;
      await expect(service.find(lastId + 1)).rejects.toThrow("Not Found");
    });
  });

  describe("testing function 'create'", () => {
    test("Should contain id, name, email, englishLevel, skills, cv and role", async () => {
      const account = await service.create({
        name: "Test user",
        email: "test@mail.com",
        password: "testuser",
        englishLevel: 10,
        skills: "coding",
        cv: "-",
        roleId: 2,
      });
      expect(account).toMatchObject({
        id: expect.any(Number),
        name: expect.any(String),
        email: expect.any(String),
        englishLevel: expect.any(Number),
        skills: expect.any(String),
        cv: expect.any(String),
        roleId: expect.any(Number),
      });
    });
  });

  describe("testing function 'findByEmail'", () => {
    test("should contain id, name, email, englishLevel, skills, cv and role", async () => {
      const user = await service.findByEmail("test@mail.com");

      expect(user).toMatchObject({
        id: expect.any(Number),
        name: expect.any(String),
        email: expect.any(String),
        englishLevel: expect.any(Number),
        skills: expect.any(String),
        cv: expect.any(String),
        roleId: expect.any(Number),
      });
    });
  });

  describe("testing function 'update'", () => {
    test("should contain id, name, email, englishLevel, skills, cv and role with updated info", async () => {
      const user = await service.findByEmail("test@mail.com");

      const updatedUser = await service.update(user.id, {
        name: "New Test Name",
      });

      expect(updatedUser).toMatchObject({
        id: expect.any(Number),
        name: expect.any(String),
        email: expect.any(String),
        englishLevel: expect.any(Number),
        skills: expect.any(String),
        cv: expect.any(String),
        roleId: expect.any(Number),
      });
      expect(updatedUser.id).toBe(user.id);
      expect(updatedUser.name).toBe("New Test Name");
    });
  });

  describe("testing function 'delete'", () => {
    test("Should return deleted id", async () => {
      const user = await service.findByEmail("test@mail.com");
      const userDeleted = await service.delete(user.id);

      expect(userDeleted).toEqual({
        id: user.id,
      });
    });
  });
});
