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
    NotRareToken private immutable minter;
    uint8 private immutable offset;
     constructor(address victim) {
        
        minter = NotRareToken(victim);

        for (uint8 i = 1; i < 6;) {
            try minter.ownerOf(i) {} catch {
                
                offset = i;
                break;
            }
            unchecked {
                i++;
            }
        }
      
        for (uint8 i = offset; i < 150 + offset;) {
            minter.mint();
            minter.transferFrom(address(this), msg.sender, i);
            unchecked {
                i++;
            }
        }


        
    }
}
