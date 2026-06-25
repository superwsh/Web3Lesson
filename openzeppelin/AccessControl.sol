// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/access/AccessControl.sol";

// account1 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 default_admin
// account3 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db manager
// account2 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 user
// account4 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB user
contract Access is AccessControl{
    bytes32 public constant ROLE_MANAGER = keccak256("ROLE_MANAGER");
    bytes32 public constant ROLE_USER = keccak256("ROLE_USER");

    constructor() {
        //DEFAULT_ADMIN_ROLE可以创建ROLE_MANAGER和ROLE_USER
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    //将创建ROLE_USER的权限转交给ROLE_MANAGER
    function setNewAdminOfRole() onlyRole(DEFAULT_ADMIN_ROLE) public {
        _setRoleAdmin(ROLE_USER, ROLE_MANAGER);
    }

    function doNormal() onlyRole(ROLE_USER) public {

    }

    function doSpecial() onlyRole(ROLE_MANAGER) public {

    }
}