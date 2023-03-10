// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
contract CrowdFunding{

    struct Request{
        string description;
        address payable recepient;
        uint value;
        uint noOfVoters;
        bool completed;
        mapping (address=>bool) voters;
    }

    mapping (address=>uint) public contributors;
    mapping (uint=>Request) public requests;
    uint public numberOfRequests;
    address public manager;
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;

    constructor(uint _target, uint _deadline){
        target=_target;
        deadline=block.timestamp+_deadline;
        manager=msg.sender;
        minimumContribution=1000 wei;
    }

    modifier onlyManager(){
        require(msg.sender==manager,"You are not the manager, Only manager can call this function");
        _;
    }

    function createRequest(string calldata _description,address payable _recepient, uint _value )public onlyManager {
        Request storage newRequest= requests[numberOfRequests];
        numberOfRequests++;
        newRequest.description=_description;
        newRequest.recepient=_recepient;
        newRequest.value=_value;
        newRequest.noOfVoters=0;
        newRequest.completed=false;
    }

    function contribution()public payable {
        require(block.timestamp<deadline,"The deadline has passed");
        require(msg.value>minimumContribution,"The minimum contribution is 1000 wei");
        if (contributors[msg.sender]==0){
            noOfContributors++;
        }
        contributors[msg.sender]+=msg.value;
        raisedAmount+=msg.value;

    }

    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }

    function refund() public {
        require(block.timestamp>deadline && raisedAmount<target && contributors[msg.sender]>0,"You are not eligible for refund");
        payable(msg.sender).transfer(contributors[msg.sender]);
        contributors[msg.sender]=0;
    }

    function voteRequest(uint _requestNo) public{
        require(contributors[msg.sender]>0,"You are not a contributor");
        Request storage thisRequest= requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false,"You have already voted");
        thisRequest.voters[msg.sender]=true;
        thisRequest.noOfVoters++;
    }

    function takePayment(uint _requestNo) public payable {
        require(raisedAmount>target,"The target is not achieved");
        Request storage thisRequest= requests[_requestNo];
        require(thisRequest.completed==false,"The payment has already been claimed");
        require(thisRequest.noOfVoters>noOfContributors/2,"Your request is not approved by community");
        thisRequest.recepient.transfer(thisRequest.value);
        thisRequest.completed=true;
        thisRequest.value=0;
    }


}