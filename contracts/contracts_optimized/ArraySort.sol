// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedArraySort {
    function sortArray(uint256[] memory _data) external pure returns (uint256[] memory) {
        unchecked {
            uint256 n = _data.length;
            uint256 gap = n / 2;

            while (gap > 0) {
                for (uint256 i = gap; i < n; i++) {
                    uint256 temp = _data[i];
                    uint256 j;
                    for (j = i; j >= gap && _data[j - gap] > temp; j -= gap) {
                        _data[j] = _data[j - gap];
                    }
                    _data[j] = temp;
                }
                gap = gap / 2;
            }
        }
        return _data;
    }
}
