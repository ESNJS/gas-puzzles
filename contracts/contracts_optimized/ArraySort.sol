// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract OptimizedArraySort {
    function sortArray(uint256[] memory _data) external pure returns (uint256[] memory) {
        uint256 dataLen = _data.length;
        uint256 i;
        while (i < dataLen) {
            uint j;
            unchecked{
                j = i+1;
            }
            
            while (j < dataLen) {
                if(_data[i] > _data[j]){
                    uint256 temp = _data[i];
                    _data[i] = _data[j];
                    _data[j] = temp;
                }
                unchecked {
                    j++;
                }
            }
            unchecked {
                i++;
            }
        }
        return _data;
    }
}
