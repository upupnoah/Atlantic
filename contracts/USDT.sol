// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract USDTTest is ERC20 {

    constructor() ERC20("USDT", "USDT") {
        _mint(address(msg.sender),100000000000 * 10 ** 18);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

   
}