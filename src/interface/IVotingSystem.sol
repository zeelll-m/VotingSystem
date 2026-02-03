//SPDX License-Identifier: MIT
pragma solidity 0.8.33;

// Interface for a Voting System
// This interface defines the structure and events for a voting system
// It includes functions for creating elections, adding candidates and voters,
// starting and ending elections, voting, and viewing election details and results.
// The interface also includes events to log significant actions in the voting process.
// The errors defined in the interface help to handle specific error cases
// such as invalid elections, ineligible persons, and voting conflicts.
// The interface is designed to be implemented by a smart contract that manages the voting process.
interface IVotingSystem {

    event electionCreated(
        uint256 indexed electionId,
        string name,
        string description,
        uint256 startTime,
        uint256 endTime
    );

    event candidateAdded(
        uint256 indexed candidateId,
        string name,
        string description,
        uint256 indexed enrollmentId
    );

    event VoterAdded(
        uint256 indexed voterId,
        string name,
        string email,
        uint256 indexed enrollmentId
    ); 

    event ElectionStarted(uint256 indexed electionId);

    event voted(
        uint256 indexed electionId,
        uint256 indexed candidateId,
        uint256 indexed voterId
    );

    event ElectionEnded(uint256 indexed electionId);

    event resultDeclared(
        uint256 indexed electionId,
        uint256[] candidateIds,
        string[] candidateNames,
        uint256[] voteCounts
    );

    error ElectionNotValid(uint256 electionId);
    error PersonNotEligible(uint256 enrollmentId);
    error CandidateNotFound(uint256 candidateId);
    error AlreadyStarted(uint256 electionId);
    error AlreadyEnded(uint256 electionId);
    error AlreadyVoted(uint256 electionId, uint256 voterId);

   function createElection(
        string memory _name,
        string memory _description,
        uint256 _startTime,
        uint256 _endTime
    ) external returns (uint256 electionId);


    function addCandidate(
        string memory _name,
        string memory _description,
        uint256 _enrollmentId
    ) external returns (uint256 candidateId);

    
    function addVoter(
        string memory _name,
        uint256 _enrollmentId
    ) external returns (uint256 voterId);
    


    function startElection(
        uint256 _electionId
    ) external returns (bool success);

    
    function vote(
        uint256 _electionId,
        uint256 _candidateId
    ) external returns (bool success);

    

    function endElection(
        uint256 _electionId
    ) external returns (bool success);  

    
    function viewElection(
        uint256 _electionId
    ) external view returns (
        string memory candidateNames,
        string memory description,
        uint256 startTime,
        uint256 endTime,
        bool isActive
    );

    function viewResult(
        uint256 _electionId
    ) external view returns (
        uint256[] memory candidateIds,
        string[] memory candidateNames,
        uint256[] memory voteCounts
    );
  

}