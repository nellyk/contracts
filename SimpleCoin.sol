pragma solidity ^0.4.0;

import './owner.sol';


contract SimpleCoin is Ownable{
    //variables
     uint256 totalSupplyValue;
     string symbol;
     mapping (address => uint) public balances;
     
    modifier onlyOwner(){
        if(msg.sender==owner){
            //the underscore represent when the function is called 
            _;
        }
    }
     modifier limitValue(uint256 _value){
        if(_value < 8888){
            //the underscore represent when the function is called 
            _;
        }
    }
    constructor() public{
        totalSupplyValue = 10000000; 
        symbol="BDC";
        balances[0xca35b7d915458ef540ade6068dfe2f44e8fa733c]= 1000;
        
    }

//total Value of the SimpleCoin/'''
    function totalSupply() public constant returns(uint256){
        return totalSupplyValue;
    }
    //owner set the address/ 
    //how do we check for the owner
    //use mapping for data structures 
    function balanceOf(address _owner) public constant returns(uint256){
        //return the balance of each adress 
         return   balances[_owner];
        
    }
  function transfer(address _to, uint256 _value) returns (bool success){
      if(balances[msg.sender] >=0){
      balances[msg.sender] -=_value;
      balances[_to]+=_value;
      return true; 
      emit Approval("successful",balances[_to]);
      }else{
          emit Approval("failed",balances[_to]);
          return false;
          }
      
  }
  function transferToFrom(address _from,address _to, uint256 _value) public limitValue(_value) returns (bool){
      //Transfer from who to who and then check balance 
      //balance[]
      //check  if value has been transfered 
      if(balances[_from]>=_value && balances[_from] <= totalSupplyValue && _value <= totalSupplyValue ){
         balances[_from] -= _value;
         balances[_to] += _value;
      emit Transfer(_from,_to,_value) ;  
      emit Approval("successful",balances[_to]);
              return true;
        
      } else{
          emit Transfer(_from,_to,_value) ;  
          emit Approval("failed",balances[_to]);
          return false;
              
          }
        
  }
function allowance(address _owner, address _spender) constant returns (uint256 remaining){
    balances[_owner] - balances[_spender];
    return remaining;
}
    event Approval(string,uint256);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
  
}