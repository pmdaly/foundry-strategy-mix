// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.6.12;

import {Strategy} from "../../Strategy.sol";
import {DSTest} from "ds-test/test.sol";
import {Utilities} from "./Utilities.sol";
import {Vm} from "forge-std/Vm.sol";

interface IDeployer {
    function newVault(
        address token,
        address guardian,
        address rewards,
        string memory name,
        string memory symbol
    ) external view returns (address);
}

contract MockBase is DSTest {
    Vm internal immutable vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    Utilities internal utils;
    // Yearn Treasury
    address govAddress = 0xFEB4acf3df3cDEA7399794D0869ef76A6EfAff52;
    // TODO: set IERC20
    address daiAddress = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address wethAddress = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address yChad = 0x50c1a2eA0a861A967D9d0FFE2AE4012c2E053804;
    address payable internal user;
    address payable internal rewards;
    address payable internal guardian;
    address payable internal management;
    address payable internal strategist;
    address payable internal keeper;

    constructor() public {
        utils = new Utilities();
        user = utils.createNamedUser("user");
        rewards = utils.createNamedUser("rewards");
        guardian = utils.createNamedUser("guardian");
        management = utils.createNamedUser("management");
        strategist = utils.createNamedUser("strategist");
        keeper = utils.createNamedUser("keeper");
    }

    function vault() internal returns (address) {
        // daiAddress is just a placeholder for now
        address _vault = IDeployer(yChad).newVault(
            daiAddress,
            guardian,
            rewards,
            "",
            ""
        );
        return _vault;
    }

    function strategy() internal returns (Strategy) {
        address _vault = vault();
        Strategy _strategy = new Strategy(_vault);
        return _strategy;
    }
}
