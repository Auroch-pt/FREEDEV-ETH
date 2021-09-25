// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/ChainLinkClient.sol";

contract APIConsumer is ChainlinkClient {
	using Chainlink for Chainlink.Request;

	bytes32 public state;

	address public oracle;
	bytes32 private jobId;
	uint256 private fee;

	constructor() {
		setChainlinkToken(0xa36085F69e2889c224210F603D836748e7dC0088);
		oracle = 0xc57B33452b4F7BB189bB5AfaE9cc4aBa1f7a4FD8;
		jobId = "7401f318127148a894c00c292e486ffd";
		fee = 0.1 * 10 ** 18; // (Varies by network and job)
	}

	function requestVolumeData() public returns (bytes32) {

		Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);

		request.add("get", "https://api.github.com/repos/Auroch-pt/FREEDEV-ETH/pulls/2/commits");

		request.add("path", "0.commit.message");

		return sendChainlinkRequestTo(oracle, request, fee);
	}

	function fulfill(bytes32 _requestId, bytes32 _state) public recordChainlinkFulfillment(_requestId) {
		state = _state;
  }
}