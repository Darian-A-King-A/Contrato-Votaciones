// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Migrations {
  address public owner;
  uint public last_completed_migration;

  constructor() {
    owner = msg.sender;
  }

  modifier restricted() {
    require(msg.sender == owner, "No autorizado");
    _;
  }

  function setCompleted(uint completed) public restricted {
    last_completed_migration = completed;
  }
}
