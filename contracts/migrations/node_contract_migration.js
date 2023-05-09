const NodeContract = artifacts.require("NodeContract");

module.exports = function (deployer) {
  deployer.deploy(NodeContract);
};