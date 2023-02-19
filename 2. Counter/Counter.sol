// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Counter {
    uint public num; //declares a public variable of type unsigned integer called num

    function increment() public {
        //declares a public function called increment
        num = num + 1; //increments the value of the variable num by 1
    }
}
