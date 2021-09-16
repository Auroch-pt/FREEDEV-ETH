const FRDVToken = artifacts.require("FRDVToken");
const FRDVPlatform = artifacts.require("FRDVPlatform");

module.exports = function (deployer, network) {
  deployer.deploy(FRDVPlatform, FRDVToken.address);
};
