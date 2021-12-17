// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./ERC721.sol";
import "./IERC721Metadata.sol";

contract SuperMarioWorld is ERC721, IERC721Metadata {
    string public override name;
    string public override symbol;
    uint256 public tokenCount;
    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(_owners[tokenId] != address(0), "Token ID does not exist!");
        return _tokenURIs[tokenId];
    }

    function mint(string memory _tokenURI) public {
        tokenCount += 1;
        _balances[msg.sender] += 1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;
        emit Transfer(address(0), msg.sender, tokenCount);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        pure
        override
        returns (bool)
    {
        return
            interfaceId == type(IERC721).interfaceId ||
            interfaceId == type(IERC165).interfaceId ||
            interfaceId == type(IERC721Metadata).interfaceId;
    }
}
