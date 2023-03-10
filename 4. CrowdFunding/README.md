# Crowd Funding Smart Contract


- This code is for a CrowdFunding contract written in Solidity
- It has a constructor that takes two arguments: target and deadline
- It has a mapping of contributors and requests, as well as other variables such as numberOfRequests, manager, minimumContribution, deadline, target, raisedAmount and noOfContributors
- It has a modifier called 'onlyManager' which requires the msg.sender to be the manager before executing the function 
- It has functions for creating requests, contributing to the fund, getting the contract balance, refunding contributions if necessary, voting on requests and taking payments if approved by the community