// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract NFT is ERC721 {
    uint256 private _nextTokenId;
    constructor(
        string memory name,
        string memory symbol
    ) ERC721(name, symbol) {}
    function mint(address to) public {
        uint256 tokenId = _nextTokenId++;
        _mint(to, tokenId);
    }
}
