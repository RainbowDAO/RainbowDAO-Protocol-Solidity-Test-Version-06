// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract daoFactory {
    

    address public admin;
    address public tokenaddress;
    uint public fee;
    mapping(address => address[]) public _USER_STD_REGISTRY_;
   
    // ============ Events ============

   
    event AdminChange(address indexed Admin, address indexed newAdmin);


    constructor(address _token,uint256 _fee)  public {
        admin = msg.sender;
        tokenaddress = _token;
        fee = fee;
    }
    
    modifier  _isOwner() {
        require(msg.sender == admin);
        _;
    }
    function changeOwner(address manager) external _isOwner {
        admin = manager;
        emit AdminChange(msg.sender,manager);
    }
    function changefee(address _token,uint256 _fee) external _isOwner {
        tokenaddress = _token;
        fee = fee;
    }
    
   function getRegistry(address user) public view returns (address[] memory )
    {
        return _USER_STD_REGISTRY_[user];
    }
}