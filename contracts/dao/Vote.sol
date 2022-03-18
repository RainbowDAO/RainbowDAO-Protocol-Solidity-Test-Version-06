pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import {StructTypes} from '../lib/StructTypes.sol';
import './RouteManage.sol';

contract Vote {
    
    
    address  public rvipAddr;//rvip合约地址
    
    address public shoppingAddr ;//市场合约地址
    
    struct OracleVote{
     address  contractAddr;
     uint     ratioFactor;
    }
   
    OracleVote [] oracleVoteArray;
   
    struct Voteinfo{
      address owner; //拥有者
      uint tokenId; //tokenId号
      uint crtTime;//生成时间
    }


    Voteinfo [] public voteArray;//全部vote
    
    mapping (address => uint) public takenByAddr; 
    
    mapping (address =>mapping (uint256 =>uint)) public  originalVote;
    
    mapping (address =>mapping (uint256 =>uint)) public  commissionedVote;
    
    mapping (address =>mapping (uint256 =>uint)) public  delegateVote;
    
    mapping (address =>mapping(address =>mapping (uint256 =>uint))) public  toDelegateVote;

    mapping(uint => uint) public everyVoteDelegateAmount; 
    
    event Transfer(address indexed from, address indexed to, uint256 value);

    event DelegateEvent(uint indexed campaignId,address indexed sender,address indexed received,uint amount);
    
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    event UndoDelegateEvent(uint indexed campaignId,address indexed sender,address indexed received);
  
    event  ChangeShoppingAddrEvent(address indexed originAddr,address indexed newAddr);
    
    event  ChangeRbVipAddrEvent(address indexed originAddr,address indexed newAddr);

   function setvote(address to) public returns(uint) {
       require(to != address(0), "ERC721: mint to the zero address");
       require(takenByAddr[to]==0,"Additional tokens have been issued");
         uint256 newTokenId = voteArray.length+1;
             Voteinfo memory vote = Voteinfo({
                owner: to,
                tokenId: newTokenId,
                crtTime:block.timestamp
            });
            voteArray.push(vote);
            takenByAddr[to]=newTokenId;
            emit Transfer(address(0), to,newTokenId);
            return newTokenId;
   }

   
    

}
