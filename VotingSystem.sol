// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract VotingSystem {
    struct Proposal {
        string title;
        uint256 yesVotes;
        uint256 noVotes;
        bool ended;
    }

    mapping(uint256 => Proposal) public proposals;
    uint256 public proposalCount;

    event ProposalCreated(uint256 id, string title);
    event Voted(uint256 id, address voter, bool votedYes);

    function createProposal(string memory title) public {
        proposals[proposalCount] = Proposal(title, 0, 0, false);
        emit ProposalCreated(proposalCount, title);
        proposalCount++;
    }

    function vote(uint256 id, bool votedYes) public {
        require(!proposals[id].ended, "Voting has ended");
        if (votedYes) {
            proposals[id].yesVotes++;
        } else {
            proposals[id].noVotes++;
        }
        emit Voted(id, msg.sender, votedYes);
    }

    function endVoting(uint256 id) public {
        proposals[id].ended = true;
    }
}