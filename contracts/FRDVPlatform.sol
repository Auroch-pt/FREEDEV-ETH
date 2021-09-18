// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FRDVPlatform {
	IERC20 public token;

	constructor(IERC20 _token) {
		token = _token;
	}
}