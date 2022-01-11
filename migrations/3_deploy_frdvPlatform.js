const FRDVToken = artifacts.require("FRDVToken");
const FRDVPlatform = artifacts.require("FRDVPlatform");

module.exports = function (deployer) {
  deployer.deploy(FRDVPlatform, FRDVToken.address);
};
