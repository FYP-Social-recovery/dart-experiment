const PublicContract = artifacts.require("PublicContract");

module.exports = function (deployer) {
  deployer.deploy(PublicContract);
};