pragma solidity ^0.8.0;

contract NumberGuessingGame {
    uint private secretNumber; // The number to be guessed
    address payable public owner; // Contract owner
    uint public participationFee = 0.01 ether; // Entry fee

    // Set contract owner and secret number initially
    function initializeGame() public {
        require(owner == address(0), "Game already initialized");
        owner = payable(msg.sender);
        secretNumber = 7; // Set a fixed secret number (can be modified later)
    }

    // Function for players to guess the number
    function guessNumber(uint guessedNumber) public payable {
        require(msg.value == participationFee, "Incorrect participation fee");
        
        if (guessedNumber == secretNumber) {
            payable(msg.sender).transfer(address(this).balance);
        }
    }

    // Function for owner to withdraw funds (if no one wins)
    function withdrawFunds() public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }
}
