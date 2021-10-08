// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ApiConsumer.sol";

contract Issue {

	address public author;
	uint256 public id;
	string public title;
	uint256 public reward;
	mapping(string => address payable) private signatureAddressMap;
	APIConsumer private apiConsumer;
	uint counter = 0;

	constructor(address _author, uint256 _id, string memory _title, uint256 _reward, APIConsumer _apiConsumer) payable {
		author = _author;
		id = _id;
		title = _title;
		reward = _reward;
		apiConsumer = _apiConsumer;
	}

	function random() public returns (bytes32){
		counter++;
		bytes32 test = bytes32(keccak256(abi.encodePacked(counter)));
		return test;
	}

	function createSignature() public {
		signatureAddressMap["ijdi12#!%!@#WQ@#!%adaadw!@#sdj31"] = payable(msg.sender);
	}
	
	function getSignature(string memory _signature, address _address) private view returns (bool) {
		return signatureAddressMap[_signature] == _address;
	}

	function bytes32ToString(bytes32 _bytes32) private pure returns (string memory) {
		uint8 i = 0;
		while(i < 32 && _bytes32[i] != 0) {
			i++;
		}
		bytes memory bytesArray = new bytes(i);
		for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
			bytesArray[i] = _bytes32[i];
		}
		return string(bytesArray);
  }

	function fulfill(bytes32 _requestId, bytes32 _state) public{
		string memory signature = bytes32ToString(_state);	   
		address payable winner = signatureAddressMap[signature];
		winner.transfer(reward);
	}

	function claimReward(string memory _url, string memory path) public {
		apiConsumer.requestVolumeData(_url, address(this), this.fulfill.selector, path);
	}
}