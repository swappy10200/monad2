// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract MembershipClub {
    struct Member {
        string name;
        uint256 joinDate;
        bool active;
    }

    mapping(address => Member) public members;
    address[] public memberList;

    event MemberJoined(address member, string name, uint256 joinDate);
    event MemberLeft(address member);

    modifier onlyActiveMember() {
        require(members[msg.sender].active, "Member is not active");
        _;
    }

    function joinClub(string memory name) public {
        require(!members[msg.sender].active, "Member already joined");
        members[msg.sender] = Member(name, block.timestamp, true);
        memberList.push(msg.sender);
        emit MemberJoined(msg.sender, name, block.timestamp);
    }

    function leaveClub() public onlyActiveMember {
        members[msg.sender].active = false;
        for (uint256 i = 0; i < memberList.length; i++) {
            if (memberList[i] == msg.sender) {
                memberList[i] = memberList[memberList.length - 1];
                memberList.pop();
                break;
            }
        }
        emit MemberLeft(msg.sender);
    }
}