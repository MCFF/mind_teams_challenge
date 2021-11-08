const boom = require("@hapi/boom");
const AccountService = require("../services/account.service");
const service = new AccountService();

describe("Account service tests", () => {
  describe("testing function 'all'", () => {
    test("Should return id, name, client name, devops name and team id", async () => {
      const accounts = await service.all();
      accounts.forEach((account) => {
        expect(account).toMatchObject({
          id: expect.any(Number),
          name: expect.any(String),
          clientName: expect.any(String),
          devOpsName: expect.any(String),
          teamId: expect.any(Number),
        });
      });
    });
  });

  describe("testing function 'find'", () => {
    test("Should return id, name, client name, devops name and team id", async () => {
      const account = await service.find(1);
      expect(account).toMatchObject({
        id: expect.any(Number),
        name: expect.any(String),
        clientName: expect.any(String),
        devOpsName: expect.any(String),
        teamId: expect.any(Number),
      });
    });
  });

  describe("testing function 'find' with no existing id", () => {
    test("Should return Account not found error", async () => {
      const account = await service.all();
      const lastId = account[account.length - 1].dataValues.id;
      await expect(service.find(lastId + 1)).rejects.toThrow(
        "Account not found"
      );
    });
  });

  describe("testing function 'create'", () => {
    test("Should return id, name, client name, devops name and team id", async () => {
      const account = await service.create({
        name: "Test account",
        clientName: "Test client",
        devOpsName: "Test devops",
        teamId: 1,
      });
      expect(account).toMatchObject({
        id: expect.any(Number),
        name: expect.any(String),
        clientName: expect.any(String),
        devOpsName: expect.any(String),
        teamId: expect.any(Number),
      });
    });
  });

  describe("testing function 'delete'", () => {
    test("Should return deleted id", async () => {
      const account = await service.all();
      const lastId = account[account.length - 1].dataValues.id;
      const accountDeleted = await service.delete(lastId);

      expect(accountDeleted).toEqual({
        id: lastId,
      });
    });
  });
});
