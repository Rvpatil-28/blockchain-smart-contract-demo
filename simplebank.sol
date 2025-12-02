contract SimpleBank {

    // Mapping to store balance of each user
    mapping(address => uint256) public balances;

    // Address of contract owner
    address public owner;

    constructor() {
        owner = msg.sender; // owner = account who deployed contract
    }

    // Deposit money into your own wallet
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
    }

    // Withdraw money from your wallet
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Update balance BEFORE transfer
        balances[msg.sender] -= amount;

        // Transfer ETH to user
        payable(msg.sender).transfer(amount);
    }

    // Check your balance
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Only owner can check total contract balance
    function getContractBalance() public view returns (uint256) {
        require(msg.sender == owner, "Only owner can check this");
        return address(this).balance;
    }
}
