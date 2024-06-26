//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract Owner{
    mapping (address=>uint) public totalBalance;
    address owner;
    uint tokenPrice=1 ether;
    constructor(){
        owner=msg.sender;
        totalBalance[owner]=100;
    }
    modifier onlyOwner(){
        require(msg.sender==owner, "You are not allowed");
        _;
    }
    function createNewToken() public onlyOwner{
        totalBalance[owner]++;
    }
    function burnToken()public onlyOwner{
        totalBalance[owner]--;
    }
    function purchaseToken() public payable {
        require((totalBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
        totalBalance[owner] -= msg.value / tokenPrice;
        totalBalance[msg.sender] += msg.value / tokenPrice;
    }

    function sendToken(address _to, uint _amount) public {
        require(totalBalance[msg.sender] >= _amount, "Not enough tokens");
        totalBalance[msg.sender] -= _amount;
        totalBalance[_to] += _amount;
    }
}
