pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import {StructTypes} from '../lib/StructTypes.sol';
import './RouteManage.sol';

contract Vote {
    
   event voteToManager(address voter,address receiver,uint amount);
   event voteToMsManagerEvent(address voter,address receiver,uint amount);

   function vote(uint256 nodeId,uint256 amount,address receiver) public {

   }

   function voteToMsManager(uint256 nodeId,uint256 amount,address receiver) public {
         
   }
    
   function endMsManagerVote(uint nodeId) public {
         
     // require(block.timestamp >  ,'Unexpired');
        
   }
    

}
