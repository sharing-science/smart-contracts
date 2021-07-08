pragma solidity >=0.4.21 <0.7.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/drafts/Counters.sol";

contract DataAccessTokens is ERC721FULL {
    using Counters for Counters.Counter;
    Counters.Counter private tokenIds;

    struct MetaData {
        string memory ipfs;
    }

    mapping(uint256 => MetaData) data_hashes;

    constructor() DataAccessTokens() public {}

    function CreateAccessToken(address owner, string ipfs) public returns (uint256) {
        tokenIds.increment();
        uint256 id = tokenIds.current();

        _mint(owner, id);

        data_hashes[id] = MetaData(ipfs);

        return id;
    }  
}