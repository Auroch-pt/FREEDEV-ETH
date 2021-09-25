// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct Issue {
	address author;
	uint256 id;
	string title;
	bool isSet;
	uint256 reward;
}