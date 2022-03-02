// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract daoFactory {
    

    address public admin;
    address public tokenaddress;
    uint public fee;
    mapping(address => address[]) public _USER_STD_REGISTRY_;
    struct DaoInfo{
        string name;
        string logo;
        string des;
        address authority;
        address manage;
        address vault;
    }
   
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
    function creatDao(string memory _name,string memory _logo,string memory _des,address manage) public {
        require(msg.sender != address(0), "Invalid address");
       
        DaoInfo memory addr = DaoInfo({
            name: _name,
            logo: _logo,
            des: _des,
            authority: address(0),
            manage: manage,
            vault: address(0)
        });
        
       
    }
    
    
   function getRegistry(address user) public view returns (address[] memory )
    {
        return _USER_STD_REGISTRY_[user];
    }
}