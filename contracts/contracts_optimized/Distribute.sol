// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedDistribute {
    error TimeLock(string message);

    address private immutable contributor_one;
    address private immutable contributor_two;
    address private immutable contributor_three;
    address private immutable contributor_four;
    uint256 private immutable createTime;

    constructor(address[4] memory _contributors) payable {
        contributor_one = _contributors[0];
        contributor_two = _contributors[1];
        contributor_three = _contributors[2];
        contributor_four = _contributors[3];
        createTime = block.timestamp + 1 weeks;
    }

    function distribute() external {
        if(block.timestamp <= createTime) revert TimeLock('cannot distribute yet');

        uint256 amount = address(this).balance / 4;
        payable(contributor_one).send(amount);
        payable(contributor_two).send(amount);
        payable(contributor_three).send(amount);
        selfdestruct(payable(contributor_four));
    }
}
