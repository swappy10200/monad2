// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

library StringUtils {
    function concat(string memory a, string memory b) internal pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }

    function contains(string memory str, string memory value) internal pure returns (bool) {
        return bytes(str).length >= bytes(value).length && keccak256(bytes(str)) == keccak256(bytes(value));
    }
}