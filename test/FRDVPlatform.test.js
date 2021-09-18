const FRDVPlatform = artifacts.require("FRDVPlatform");
const FRDVToken = artifacts.require("FRDVToken");

contract("FRDVPlatform", () => {
  before(async () => {
    frdvPlatform = await FRDVPlatform.deployed();
    frdvToken = await FRDVToken.deployed();
  });

  it("set FRDVToken as the platform token", async () => {
    let token = await frdvPlatform.token();
    assert.equal(token, frdvToken.address);
  });
});
