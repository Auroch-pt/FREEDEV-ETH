// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* struct Issue {
	address author;
	uint256 id;
	string title;
	bool isSet;
	uint256 reward;
} */

contract Issue {

	address author;
	uint256 id;
	string title;
	uint256 reward;

	constructor(address _author, uint256 _id, string memory _title, uint256 _reward) {
		author = _author;
		id = _id;
		title = _title;
		reward = _reward;
	}

}