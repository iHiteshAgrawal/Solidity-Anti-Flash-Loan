pragma solidity ^0.8.0;

contract AntiFlashLoan {
    address public owner;

    mapping(address => bool) public isWhitelisted;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Block all proxies (including flash loans).
    modifier antiProxy() {
        require(tx.origin == msg.sender, "Proxy call not allowed.");
        _;
    }

    // Block all non-whitelisted proxies (including flash loans).
    modifier antiFlashLoan() {
        if (!isWhitelisted[msg.sender]) {
            require(tx.origin == msg.sender, "Proxy not whitelisted.");
        }
        _;
    }

    // Whitelist proxy.
    function whitelistProxy(address proxy) external onlyOwner {
        isWhitelisted[proxy] = true;
    }
}
