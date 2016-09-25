describe("Santity checks", () => {

    it("true should be truthy", () => { expect(true).toBeTruthy(); });
    it("false should be falsy", () => { expect(false).toBeFalsy(); });
    it("1 is less than 2", () => { expect(1).toBeLessThan(2); })
    it("4 to be greater than 3", () => expect(4).toBeGreaterThan(3));
    it("undefined is undefined", () => expect(undefined).toBeUndefined());
    it("null is defined", () => expect(null).toBeDefined());
    it("null is null", () => expect(null).toBeNull());
});