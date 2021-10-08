// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Issue.sol";

contract Project {
	address public author;
	string public title;
	mapping(address => Issue) public issueMap;

	constructor(address _author, string memory _title) {
		author = _author;
		title = _title;
	}

	function createIsssue(address _address, uint256 _id, string memory _title, uint256 _reward, APIConsumer _apiConsumer) public returns (Issue issue){
		require(_address == author, "You are not the author of this project");
		Issue newIssue = new Issue(author, _id, _title, _reward, _apiConsumer);
		issueMap[address(newIssue)] = newIssue;
		return newIssue;
	}

	function getIssue(address _issueAdd) public view returns (Issue issue) {
		return issueMap[_issueAdd];
	}
}