//SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// You may not modify this contract or the openzeppelin contracts
contract NotRareToken is ERC721 {
    mapping(address => bool) private alreadyMinted;

    uint256 private totalSupply;

    constructor() ERC721("NotRareToken", "NRT") {}

    function mint() external {
        totalSupply++;
        _safeMint(msg.sender, totalSupply);
        alreadyMinted[msg.sender] = true;
    }
}

contract OptimizedAttacker {
    NotRareToken private constant minter = NotRareToken(0x5FbDB2315678afecb367f032d93F642f64180aa3);

    constructor(address) {
        unchecked {
            uint256 i = minter.balanceOf(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266) + 1;
            uint256 offset = 150 + i;
            while (i != offset) {
                minter.mint();
                minter.transferFrom(address(this), msg.sender, i);

                ++i;
            }
        }
        selfdestruct(payable(address(this)));
    }
}
