// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./User.sol";

contract FRDVPlatform {
	IERC20 public token;
	mapping(address => User) public users;

	constructor(IERC20 _token) {
		token = _token;
	}

	function createUser(string memory _username) public {
		User storage newUser = users[msg.sender];
		require(!newUser.set, "User already exists.");
		users[msg.sender] = User({username: _username, set: true});
	}

	function getUser(address _address) public view returns (User memory){
		return users[_address];
	}
}