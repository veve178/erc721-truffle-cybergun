// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "../node_modules/@openzeppelin/contracts/utils/Strings.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract CyberGun is ERC721Enumerable, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string private _baseTokenURI;
    string private _contractURI;

    // set contract name and ticker. 
    constructor() ERC721("CyberGun", "CG") {
        _baseTokenURI = "ipfs://QmZxPBEzPcJcXLGe4Qqx9K2KYKVgxbJvJSjxq5Aq3eRLvu";
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

    // for opensea collection 
    function contractURI() public view returns (string memory) {
        return _contractURI;
    }

    function setContractURI(string calldata newContractURI) external onlyOwner {
        _contractURI = newContractURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    
    // get the max supply of tokens
    function maxSupply() public pure returns (uint256) {
        return 10000;
    }

    // get the current supply of tokens
    function totalSupply() public view override returns (uint256) {
        return _tokenIds.current();
    }

    function mintItem(address player)
        public
        onlyOwner
        returns (uint256)
    {
        require(totalSupply() <= maxSupply(), "Reached maximum supply");
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);        
        return newItemId;
    }

    function burn(uint256 tokenId) onlyOwner public{
        _burn(tokenId);
    }
}
