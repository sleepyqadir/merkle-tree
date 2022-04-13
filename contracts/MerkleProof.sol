//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MerkleProof {   
    
    bytes32[] public hashes;

    function verify(bytes32[] memory proofs, bytes32 root, bytes32 leaf, uint index
    ) public pure returns (bool){

        bytes32 hash = leaf;
        for (uint256 i = 0; i < proofs.length; i++) {
            if(index % 2 == 0){
                hash = keccak256(abi.encodePacked(hash,proofs[i]));
            }
            else {
                hash = keccak256(abi.encodePacked(proofs[i],hash));
            }
            index = index/2;   
        }
        return hash == root;
    }

    function construct(string[] memory transactions) public {
        
        for (uint256 index = 0; index < transactions.length; index++) {
            hashes.push(keccak256(abi.encodePacked(transactions[index])));
        }

        uint n = transactions.length;
        uint offset = 0;           

        while(n>0){
            for (uint256 i = 0; i < n-1; i+=2) {
                hashes.push(keccak256(abi.encodePacked(hashes[offset +i], hashes[offset +i+1])));
            }
            offset +=n;
            n = n/2;
        }
    }

    function getHashes() public view returns(bytes32[] memory) {
        return hashes;
    }

    function getRoot() public view returns(bytes32){
        return hashes[hashes.length -1];
    }
}