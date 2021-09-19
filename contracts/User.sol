// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Project.sol";

struct User {
	string username;
	bool isSet;
	Project[] projectArr;
}