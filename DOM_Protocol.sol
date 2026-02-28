// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title The DOM Protocol (Digital On-Thousand Assembly)
 * @author Mr-KY-ra
 * @notice Experimental Meritocratic Governance Contract
 */
contract CyberMeritocracy {
    
    struct Ballot {
        string description;
        uint256 voteCount;
        bool active;
    }

    mapping(address => bool) public isDelegate;
    mapping(uint256 => Ballot) public ballots;
    mapping(address => mapping(uint256 => bool)) public hasVoted;

    uint256 public delegateCount;
    uint256 public ballotCount;
    address public systemAdmin;

    constructor() {
        systemAdmin = msg.sender;
    }

    // Liyakat Onayı: Sınavı geçen vekilin anonim cüzdan kaydı
    function registerDelegate(address _delegateAddress) public {
        require(msg.sender == systemAdmin, "Only System Admin can register delegates.");
        require(delegateCount < 10000, "10,000 delegate limit reached.");
        
        isDelegate[_delegateAddress] = true;
        delegateCount++;
    }

    // Yasa/Bütçe Teklifi
    function proposeLaw(string memory _description) public {
        ballotCount++;
        ballots[ballotCount] = Ballot(_description, 0, true);
    }

    // Anonim Oylama
    function castVote(uint256 _ballotId) public {
        require(isDelegate[msg.sender], "Not a registered delegate.");
        require(!hasVoted[msg.sender][_ballotId], "Already voted.");
        require(ballots[_ballotId].active, "Ballot is closed.");

        ballots[_ballotId].voteCount++;
        hasVoted[msg.sender][_ballotId] = true;
    }
}
