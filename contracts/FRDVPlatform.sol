// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./User.sol";
import "./Project.sol";

contract FRDVPlatform {
	IERC20 public token;
	mapping(address => User) public users;
	mapping(uint256 => Project) public projects;
	uint256 public projectsCounter = 0;

	constructor(IERC20 _token) {
		token = _token;
	}

	function createUser(string memory _username) public {
		User storage newUser = users[msg.sender];
		require(!newUser.set, "User already exists.");
		newUser.username = _username;
		newUser.set = true;
	}

	function getUser(address _address) public view returns (User memory){
		require(users[_address].set, "User doesn't exists.");
		return users[_address];
	}

	function createProject(string memory _title) public {
		Project storage newProject = projects[projectsCounter];
		require(!newProject.set, "Project already exists.");
		newProject.author = msg.sender;
		newProject.id = projectsCounter;
		newProject.title = _title;
		newProject.set = true;
		users[msg.sender].projects.push(projects[projectsCounter]);
		projectsCounter++;
	}

	function getProject(uint256 _projectId) public view returns (Project memory){
		require(projects[_projectId].set, "Project doesn't exists.");
		return projects[_projectId];
	}
}