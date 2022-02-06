// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

import {DSTest} from "ds-test/test.sol";
import {Utilities} from "./utils/Utilities.sol";
import {console} from "./utils/Console.sol";
import {Vm} from "forge-std/Vm.sol";

contract MigrationTest is DSTest {
    Vm internal immutable vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    Utilities internal utils;
    address payable[] internal users;

    function setUp() public {
        utils = new Utilities();
        users = utils.createUsers(5);
    }

    function testOne() public {
        address payable alice = users[0];
        vm.label(alice, "Alice");
        console.log("alice's address: ", alice);
    }
}
