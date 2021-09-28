pragma solidity 0.8.7;

contract PayMe
{
    address payable public owner;
    address public topDonator;
    uint256 public topAmount = 0;
    uint256 public totalDonations = 0;
    
    constructor () payable
    {
        owner = payable(msg.sender);
    }
    
    modifier onlyOwner
    {
        require(msg.sender == owner);
        _;
    }
    
    function Withdraw() public payable onlyOwner
    {
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success, "Failed to withdraw eth");
    }
    
    function PayUp() public payable
    {
        totalDonations += msg.value;
        
        if (msg.value > topAmount)
        {
            topDonator = msg.sender;
            topAmount = msg.value;
        }
    }
}
