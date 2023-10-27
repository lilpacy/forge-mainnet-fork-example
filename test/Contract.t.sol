// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.6;

import "ds-test/test.sol";

// for cheatcodes
interface Vm {
    function prank(address) external;

    function warp(uint256) external;
}

// to verfiy that we recevied Dai
interface Dai {
    function balanceOf(address) external view returns (uint256);
}

contract ContractTest is DSTest {
    Vm vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    Dai dai = Dai(0x6B175474E89094C44Da98b954EedeAC495271d0F);

    // your address
    address constant myAddress = 0x6DFbc2eAD08C2f3b9674a7D0795660d59C04Ac92;

    // contract address from MetaMask
    address constant swapDai = 0x3fC91A3afd70395Cd496C647d5a6CC9D4B2b7FAD;

    function testSwap() public {
        // to verify if we are actually forking
        emit log_named_uint("Current ether balance of myAddress", myAddress.balance);

        emit log_named_uint("Dai balance of myAddress before", dai.balanceOf(myAddress));

        // type casting hex call data to bytes
        bytes memory data =
            hex"paste the hex call data here. Remove the leading '0x'";

        // setting the next call's msg.sender as myAddress
        vm.prank(myAddress);

        (bool sent,) = payable(swapDai).call{value: 0.1 ether}(data);
        require(sent, "failed");

        emit log_named_uint("Dai balance of myAddress after", dai.balanceOf(myAddress));
    }
}
