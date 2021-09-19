// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./User.sol";
import "./Project.sol";

contract FRDVPlatform {
	IERC20 public token;
	mapping(address => User) public userMap;
	mapping(uint256 => Project) public projectMap;
	uint256 public projectCounter = 0;

	constructor(IERC20 _token) {
		token = _token;
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

	function createProject(string memory _title) public {
		Project storage newProject = projectMap[projectCounter];
		require(!newProject.isSet, "Project already exists.");
		newProject.author = msg.sender;
		newProject.id = projectCounter;
		newProject.title = _title;
		newProject.isSet = true;
		userMap[msg.sender].projectArr.push(projectMap[projectCounter]);
		projectCounter++;
	}

	function getProject(uint256 _projectId) public view returns (Project memory project){
		require(projectMap[_projectId].isSet, "Project doesn't exists.");
		return projectMap[_projectId];
	}
}