// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ApiConsumer.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./User.sol";
import "./Project.sol";
import "./Issue.sol";
import "./FRDVToken.sol";

contract FRDVPlatform {
	IERC20 public token;
	mapping(address => User) public userMap;
	mapping(address => Project) public projectMap;
	mapping(address => Issue) public issueMap;
	APIConsumer private apiConsumer;
	
	event Bought(uint256 amount);
	event Sold(uint256 amount);

	constructor() payable {
		token = new FRDVToken(10000000);
		apiConsumer = new APIConsumer();
	}

	function buyTokens() public payable {
		uint256 amountTobuy = 1000;
		uint256 dexBalance = token.balanceOf(address(this));
		require(amountTobuy <= dexBalance, "Not enough tokens in the reserve");
		token.transfer(msg.sender, amountTobuy);
		emit Bought(amountTobuy);
	}
	
	function getBalance(address _address) public view returns (uint256 balance) {
		return token.balanceOf(_address);
	}

	function createUser(string memory _username) public {
		User storage newUser = userMap[msg.sender];
		require(!newUser.isSet, "User already exists.");
		newUser.username = _username;
		newUser.isSet = true;
	}

	function getUser(address _address) public view returns (string memory username, bool isSet){
		require(userMap[_address].isSet, "User doesn't exists.");
		return (userMap[_address].username, userMap[_address].isSet);
	}

	function createProject(string memory _title) public returns (Project project) {
		Project newProject = new Project(msg.sender, _title);
		projectMap[address(newProject)] = newProject;
		userMap[msg.sender].projectArr.push(projectMap[address(newProject)]);
		return newProject;
	}

	function getProject(address _projectAdd) public view returns (Project project) {
		return projectMap[_projectAdd];
	}

	function createIsssue(address _projectAdd, uint256 _id, string memory _title, uint256 _reward) public returns (Issue issue){
		require(_reward > 0, "The reward must be greater than 0");
		require(token.balanceOf(msg.sender) >= _reward, "You don't have the reward tokens");
		Issue newIssue = projectMap[_projectAdd].createIsssue(msg.sender, _id, _title, _reward, apiConsumer);
		issueMap[address(newIssue)] = newIssue;
		token.transferFrom(msg.sender, address(newIssue), _reward);
		return newIssue;
	}

	function getIssue(address issueAddress) public view returns (Issue issue) {
		return issueMap[issueAddress];
	}
}