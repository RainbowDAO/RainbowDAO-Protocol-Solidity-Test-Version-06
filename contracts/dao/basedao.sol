// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './DaoManager.sol';
import './lib/TransferHelper.sol';
import {Set} from "./lib/TokenSet.sol";

contract baseDao{
    using Set for Set.Address;

    address public dao;
    Set.AddressSet private users;
    Set.AddressSet private verifyUsers;

    address public manager;

    bool public joinVerify;
    bool public dismissStatus;

    address public token;

    constructor(address _dao){
        dao = _dao;
    }

    modifier  _isOwner() {
        require(msg.sender == manager);
        _;
    }
    modifier  _isOpen() {
        require(dismissStatus == false ,'the group is close');
        _;
    }

    function joinGroup() public _isOpen {
        require(DaoManager(dao).checkUserExists(msg.sender) == true ,'not in this dao');
        if(joinVerify){
            require(verifyUsers.contains(msg.sender) == false,'Already joined');
            verifyUsers.add(msg.sender);
        }else{
            require(users.contains(msg.sender) == false,'Already joined');
            users.add(msg.sender);
        }
    }

    function leaveGroup() public  {
        users.remove(msg.sender);
    }

    function setManager(address _manager) public _isOpen {
        require(msg.sender == getDaoManager(),'no access');
        manager  = _manager;
    }


    function getDaoManager() public view returns(address) {
       return DaoManager(dao).manager();
    }

    function getUserCount() public view returns(uint) {
        return users.length();
    }

    function getUserByIndex(uint _index) public view returns(address) {
        return users.at(_index);
    }

    function getVerifyUserCount() public view returns(uint) {
        return verifyUsers.length();
    }

    function getVerifyUserByIndex(uint _index) public view returns(address) {
        return verifyUsers.at(_index);
    }

    function examineVerifyUser(address _user) public _isOwner _isOpen {
        require(verifyUsers.contains(msg.sender) == true,'not found this user apply');
        require(users.contains(msg.sender) == false,'Already this user');
        verifyUsers.remove(_user);
        users.add(_user);
    }
    
    function setJoinVerify(bool _status) public _isOwner  _isOpen {
        joinVerify = _status;
    }
    
    function dismiss(address _vault) public override _isOpen {
        require(msg.sender == dao ,'no access');
        dismissStatus = true;
        uint balance = IERC20(token).balanceOf(address(this));
        TransferHelper.safeTransfer(token,_vault,balance);
    }

    
    
    
}