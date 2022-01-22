pragma solidity ^0.5.0;


//This contract will allow users to take four actions. 
/* Specifically, they’ll be able to 
1. Check their arcade token balances
2. Transfer tokens between users 
3. Purchase new tokens
4. Mint tokens for the arcade.
*/
contract ArcadeToken {
    //Owner of the ArcadeToken contract 
    /*The contract owner will receive the initial supply of tokens
     when the contract gets deployed. 
     This owner will also be responsible for transferring those 
     tokens to recipients and creating new tokens as necessary
    */
    address payable public owner = msg.sender; // the account that creates the smart contract. 
    string public symbol = "ARCD"; 

    /*
     For every 1 wei that a customer spends,
      they receive 100 arcade tokens.*/
    uint public exchange_rate = 100; 

    mapping(address => uint) balances;


    /*We want arcade customers to access their balances: 
    Check the number of arcade tokens that are available in 
    their accounts.*/

    /*FETCH ACCOUNT BALANCE */

    function balance() public view returns(uint) {
        return balances[msg.sender];
    }


    /*TRANSFER A BALANCE*/
    // Function to allow users to transfer between accounts
    //value will represent the number of tokens being transferred
    function transfer(address recipient, uint value) public {
        balances[msg.sender] -= value; 
        balances[recipient]+= value; 
    }

    /*PURCHASE TOKENS FROM SMART CONTRACT*/

    function purchase() public payable {
    //msg.value = amount of ether that the customer is spending 
    //exchange rate, set earlier to 100 
    //msg.sender - customer who's currently purchasing tokens 
        uint amount = msg.value * exchange_rate; 
        balances[msg.sender] += amount; 

        /*We transfer the ether that the customer spent 
        purchasing tokens to the arcade owner*/
        owner.transfer(msg.value); 
    }

    /*MINT TOKENS*/
    //ability oto create tokens 
    function mint(address recipient, uint value) public{
    require(msg.sender ==owner, "You do not have permission to mint tokens");

        balances[recipient]+=value; 
    
    }



}
