// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

interface IAgentId {
    function balanceOf(address account) external view returns (uint256);
}

/// @title GoblinAgentGate
/// @notice GOBLIN PROTOCOL distribution gate for Binance Agent ID holders.
/// Any wallet holding a BSC .ai Agent ID (SPACE ID Agent ID registry,
/// ERC-721, non-transferable) can claim a fixed $GOBLIN allocation once
/// per Agent ID. Claims are paid from this contract's $GOBLIN balance,
/// funded by the GOBLIN PROTOCOL treasury wallet.
contract GoblinAgentGate {
    IAgentId public constant AGENT_ID = IAgentId(0x60B9262456dE011F7d15a54CdD8c48bAaa8B022F);
    IERC20 public immutable goblin;
    uint256 public immutable claimAmount;
    address public owner;

    mapping(address => bool) public claimed;
    uint256 public totalClaimants;

    event Claimed(address indexed account, uint256 amount);
    event Funded(address indexed from, uint256 amount);

    constructor(address goblinToken, uint256 claimAmount_) {
        goblin = IERC20(goblinToken);
        claimAmount = claimAmount_;
        owner = msg.sender;
    }

    /// @notice True when the account holds a Binance Agent ID.
    function hasAgentId(address account) external view returns (bool) {
        return AGENT_ID.balanceOf(account) > 0;
    }

    /// @notice Claim the $GOBLIN allocation. One claim per Agent ID holder address.
    function claim() external {
        require(AGENT_ID.balanceOf(msg.sender) > 0, "no Agent ID");
        require(!claimed[msg.sender], "already claimed");
        uint256 amount = claimAmount;
        require(goblin.balanceOf(address(this)) >= amount, "gate empty");
        claimed[msg.sender] = true;
        totalClaimants += 1;
        require(goblin.transfer(msg.sender, amount), "transfer failed");
        emit Claimed(msg.sender, amount);
    }
}
