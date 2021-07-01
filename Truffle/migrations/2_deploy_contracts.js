const Bmd = artifacts.require("BioMedicalDataToken");


module.exports = function(deployer) {
  const name = "Kacy";
  deployer.deploy(Bmd, 50, name);
};
