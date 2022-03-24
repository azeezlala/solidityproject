pragma solidity ^0.8.0;

library Mylibrary {
    function divide(uint256  a, uint256  b) internal pure returns (uint256) {
        require(b > 0);
        uint256 c = a / b;
        return c;
    }
}
