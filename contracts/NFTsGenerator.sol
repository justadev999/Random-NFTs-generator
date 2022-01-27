// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract NFTsGenerator {
    address public owner;
    uint256 startingPrice = 0.02 ether;
    uint256 nftId = 6;
    uint256 nftModuleId = nftId**10;

    struct NFT {
        string name;
        uint256 price;
        uint256 id;
    }

    NFT[] public nftsCollection;

    //CREATE THE NFT
    function createNft(
        string memory _name,
        uint256 _price,
        uint256 _id
    ) private {
        nftsCollection.push(NFT(_name, _price, _id));
    }

    //GENERATE A RANDOM ID FOR IT
    function _generateRandomId(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 randomId = uint256(keccak256(abi.encodePacked(_str)));
        return randomId % nftModuleId;
    }

    function generateRndomNft(string memory _name, uint256 _price) public {
        uint256 randomId = _generateRandomId(_name);
        createNft(_name, _price, randomId);
    }
}
