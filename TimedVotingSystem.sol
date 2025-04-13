// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract TimedVotingSystem {
    struct Proposal {
        string title;
        uint256 yesVotes;
        uint256 noVotes;
        uint256 startTime;
        uint256 endTime;
        bool ended;
    }

    mapping(uint256 => Proposal) public proposals;
    uint256 public proposalCount;

    event ProposalCreated(uint256 id, string title, uint256 startTime, uint256 endTime);
    event Voted(uint256 id, address voter, bool votedYes);

    function createProposal(string memory title, uint256 startTime, uint256 endTime) public {
        require(startTime < endTime, "Start time must be before end time");
        proposals[proposalCount] = Proposal(title, 0, 0, startTime, endTime, false);
        emit ProposalCreated(proposalCount, title, startTime, endTime);
        proposalCount++;
    }

    function vote(uint256 id, bool votedYes) public {
        require(block.timestamp >= proposals[id].startTime && block.timestamp <= proposals[id].endTime, "Voting is not active");
        require(!proposals[id].ended, "Voting has ended");
        if (votedYes) {
            proposals[id].yesVotes++;
        } else {
            proposals[id].noVotes++;
        }
        emit Voted(id, msg.sender, votedYes);
    }

    function endVoting(uint256 id) public {
        require(block.timestamp > proposals[id].endTime, "Voting is still active");
        proposals[id].ended = true;
    }
}