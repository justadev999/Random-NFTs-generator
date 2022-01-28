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
    //I'm gonna track the nft's IDs for the respective owners
    mapping(uint256 => address) public nftToOwner;
    //Storing the number of NFTs owned by a sngle address
    mapping(address => uint256) ownerNftsCollection;

    //Emitting NFT's creation event needed on the FE
    event NewNft(string name, uint256 price, uint256 id);

    //CREATE THE NFT
    function createNft(
        string memory _name,
        uint256 _price,
        uint256 _id
    ) private {
        nftsCollection.push(NFT(_name, _price, _id));
        // I need to declare afterwards the index's position of the id 'cause after sol 0.6
        //the push method changed behavior. It doesn't return anyore the length but a ref to it.
        uint256 id = nftsCollection.length - 1;
        nftToOwner[id] = msg.sender;
        ownerNftsCollection[msg.sender]++;
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
