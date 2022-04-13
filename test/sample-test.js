const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MerkleProof", function () {
  it("Should return the true when proofs are provided", async function () {
    const MerkleProof = await ethers.getContractFactory("MerkleProof");
    const merkle = await MerkleProof.deploy();
    await merkle.deployed();

    const proofs = ["0x78a93af7ef9f1380d64a61c552cbefc298da07acb65530265b8ade6ebe8218c4", "0x2f71627ef88774789455f181c533a6f7a68fe16e76e7a50362af377269aabfee"];

    const index = 1;

    const leaf = "0x92ae03b807c62726370a4dcfecf582930f7fbb404217356b6160b587720d3ba7"

    const transactions = ["alice -> bob",
      "bob -> dave",
      "carol -> alice",
      "dave -> bob"]

    await merkle.construct(transactions);


    const getHashes = await merkle.getHashes();


    const root = await merkle.getRoot();

    console.log(await merkle.verify(proofs, root, leaf, index));


    expect(await merkle.verify(proofs, root, leaf, index)).to.equals(true)
  });
});
