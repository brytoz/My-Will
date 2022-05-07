// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.4;

contract Willme {
    
        //define the required variables
        address AssetOwner;
        uint32 id;
        bool isPermit;
        bool isNotAlive;
    

    //general concept of constructor
    constructor() payable public {
        AssetOwner = msg.sender;
        id = 483232424; //static id made for development purpose (owners lock key. Only the lawyer and owner have this key
        isPermit    =   false; //lawyer permission
        isNotAlive    =   false;
    }

    //if statement that modifies the owner to allocate assets to inheritance
    modifier theOwner {
        require(msg.sender ==  AssetOwner);
        _;
    }



    //if statement that modifies the ChildInheritance to take assets if only the assets owner is dead
    modifier isDead {
        require(isNotAlive == true);
        _;
    }


    //user input
    uint32[]   Lawyer;


    //list of inheritance wallets
    address payable[] theAllowedWallets;

    //maps through all wallets with address
    mapping (address => uint256) inheritance;


    //set Childinheritance foreach address
    function setChildInheritance(address payable wallet, uint256 amounts) public {
        theAllowedWallets.push(wallet);
        inheritance[wallet] = amounts;

    }

    //distribute assets to childInheritance
    function giveAssets() private isDead {
        for(uint x = 0; x < theAllowedWallets.length; x++){
            theAllowedWallets[x].transfer(inheritance[theAllowedWallets[x]]); //portion of funds transfer from assets owner to childinheritance
        }
    }


    //when the lawyer verifies the user is no longer alive
    function LawyerCheckID(uint32 code) public {
        Lawyer.push(code);
        require( Lawyer[0] == 483232424);
        isPermit = true;
    }

    //the automated oracle auto generate
    function Dead() public theOwner {
        require(isPermit == true);
        isNotAlive = true;
        giveAssets();
    } 

}
