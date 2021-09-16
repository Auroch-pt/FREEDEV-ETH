const FRDVToken = artifacts.require("FRDVToken");

module.exports = function (deployer) {
  deployer.deploy(FRDVToken, 1000000);
};
