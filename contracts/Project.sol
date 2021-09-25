// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Issue.sol";

struct Project {
	address author;
	uint256 id;
	string title;
	bool isSet;
	Issue[] issueArr;
}