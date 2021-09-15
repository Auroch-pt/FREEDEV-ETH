const FRDVToken = artifacts.require("FRDVToken");

contract("FRDVToken", (accounts) => {
  before(async () => {
    frdvToken = await FRDVToken.deployed();
  });

  it("gives the owner of the token 1M tokens", async () => {
    let balance = await frdvToken.balanceOf(accounts[0]);
    balance = web3.utils.fromWei(balance, "ether");
    assert.equal(
      balance,
      "1000000",
      "Balance should be 1M tokens for contract creator"
    );
  });
});
