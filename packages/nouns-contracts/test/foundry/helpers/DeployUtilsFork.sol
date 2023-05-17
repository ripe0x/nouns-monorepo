// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;

import 'forge-std/Test.sol';
import { DeployUtilsV3 } from './DeployUtilsV3.sol';
import { NounsDAOLogicV3 } from '../../../contracts/governance/NounsDAOLogicV3.sol';
import { NounsDAOExecutorV2 } from '../../../contracts/governance/NounsDAOExecutorV2.sol';
import { ForkDAODeployer } from '../../../contracts/governance/fork/ForkDAODeployer.sol';
import { NounsTokenFork } from '../../../contracts/governance/fork/newdao/token/NounsTokenFork.sol';
import { NounsAuctionHouseFork } from '../../../contracts/governance/fork/newdao/NounsAuctionHouseFork.sol';
import { NounsDAOLogicV1Fork } from '../../../contracts/governance/fork/newdao/governance/NounsDAOLogicV1Fork.sol';

abstract contract DeployUtilsFork is DeployUtilsV3 {
    function _deployForkDAO(address escrow)
        public
        returns (
            address treasury,
            address token,
            address dao
        )
    {
        ForkDAODeployer deployer = new ForkDAODeployer(
            address(new NounsTokenFork()),
            address(new NounsAuctionHouseFork()),
            address(new NounsDAOLogicV1Fork()),
            address(new NounsDAOExecutorV2()),
            escrow,
            DELAYED_GOV_DURATION
        );

        (treasury, token) = deployer.deployForkDAO(block.timestamp + FORK_PERIOD);
        dao = NounsDAOExecutorV2(payable(treasury)).admin();
    }

    function _deployForkDAO()
        public
        returns (
            address treasury,
            address token,
            address dao
        )
    {
        NounsDAOLogicV3 originalDAO = _deployDAOV3();
        return _deployForkDAO(address(originalDAO.forkEscrow()));
    }
}
