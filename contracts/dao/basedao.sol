// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;



contract baseDao{
    address public owner;
    uint public index;
    
    struct DaoInfo{
        string name;
        string logo;
        string des;
        address authority;
        address manage;
        address vault;
    }
    mapping(address => uint[]) public userDaos;
    DaoInfo[] public array;
    
    constructor(address _owner) public {
        owner = _owner;
    }
    
    modifier onlyOnwer(){
        require(msg.sender == owner, "only owner");
        _;
    }
    
    
    
    
}