pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna); //event that passes the id,name and dna of the zombie.

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits; //uint to make sure the hashing of the string results in 16 digits.

    struct Zombie {
        string name;
        uint dna;
    }                   

    Zombie[] public zombies;   //dynamic array to collect all zombie details.

    function _createZombie(string _name, uint _dna) private {          //function to create the zombie.
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);         //firing the event to the front-end.
    }

    function _generateRandomDna(string _str) private view returns (uint) {    //function to generate a random 16 digit number based on the string input.
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public { //function to call the createZombie function.
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}