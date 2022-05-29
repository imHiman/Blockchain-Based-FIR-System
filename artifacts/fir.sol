/**
 *Submitted for verification at Etherscan.io on 2022-05-04
*/

pragma solidity ^0.8.0;

contract fir{

    address owner;             //Smart Contract Owner
    uint[]  fir_id;
    address[]  police_address;

/* ----------------------------Police Data----------------------------------- */
    struct Police_Data{
        address u_address;
        string name;
        string designation;
        string station;              //use dropdown button for selection of station
        bool kyc;
    }
/* ----------------------------Police Data----------------------------------- */





/* ----------------------------FIR Data----------------------------------- */
    struct Fir_Data{
        uint u_id;
        uint blocktime;
        address user_address;
        string name;
        string gender;
        uint age;
        uint contact_number;
        string postal_address;
        string fir_description;
        string allot_police_station;   //use dropdown button for selection of station
        string incident_related_to;   //use dropdown button for selection of station
        string status;
        string remark;
    }
/* ----------------------------FIR Data----------------------------------- */



/* ----------------------------Object Creation----------------------------------- */
    mapping(address => Police_Data) police_data;
    
    mapping(uint => Fir_Data) fir_data;

    // mapping(address=>uint[])c_id;
/* ----------------------------Object Creation----------------------------------- */



    event id(uint msg);         // Events to be used for Run time to get function executed output



    constructor() public{
        owner = msg.sender;
        require(police_data[msg.sender].u_address == address(0), "Account already exists");
        police_data[msg.sender].kyc = true;
    }


// KYC for Policeman which will be done by Smart Contract Owner
// Policeman has free registration but no access to write data till KYC
    function createKYC(address _adrs) public {
        require( msg.sender == owner, "You are not the Super Admin." );
        require( police_data[_adrs].kyc == false, "KYC already completed." );
        police_data[_adrs].kyc = true;
    }





//--------------------------------- Police Registration---------------------------------------
    function registerPolice(string memory _name, string memory _designation, string memory _station) public
    {
         require(police_data[msg.sender].u_address == address(0), "Account already exists");
         police_data[msg.sender].u_address = msg.sender;
         police_data[msg.sender].name = _name;
         police_data[msg.sender].designation = _designation;
         police_data[msg.sender].station = _station;
         police_address.push(msg.sender);
    }
//--------------------------------- Police Registration---------------------------------------




//---------------------------------FIR Status will be update by Policeman-----------------------
    function updateStatus(uint _u_id, string memory _remark, string memory _status) public
    {
         require(police_data[msg.sender].kyc == true, "Access Denied");
         
         fir_data[_u_id].remark = _remark;
         fir_data[_u_id].status = _status;
    }
//---------------------------------FIR Status will be update by Policeman-----------------------






// --------------------------User can create FIR----------------------------------------------
    function createFIR( string memory _allot_police_station, string memory _name, string memory _gender, uint  _age, uint _contact_number, string memory _postal_address, string memory _incident_related_to, string memory _fir_description) public{
        uint u_id = uint(keccak256(abi.encodePacked(_fir_description)));
        fir_id.push(u_id);
        fir_data[u_id].u_id = u_id;
        fir_data[u_id].name = _name;
        fir_data[u_id].gender = _gender;
        fir_data[u_id].age = _age;
        fir_data[u_id].contact_number = _contact_number;
        fir_data[u_id].postal_address = _postal_address;
        fir_data[u_id].incident_related_to = _incident_related_to;
        fir_data[u_id].allot_police_station = _allot_police_station;
        fir_data[u_id].blocktime = block.timestamp;
        fir_data[u_id].user_address = msg.sender;
        fir_data[u_id].fir_description = _fir_description;
        emit id(u_id);
    }
// --------------------------User can create FIR----------------------------------------------





//--------------------Returns Smart Contract Owner Address--------------
    function getOwner() public view returns(address) {
        return owner;
    }


//--------------------------Fetch Policeman Details-----------------------
    function getPoliceDetails(address _address) public view returns(address,string memory,string memory,string memory,bool){
        return(police_data[_address].u_address,police_data[_address].name,police_data[_address].designation,police_data[_address].station,police_data[_address].kyc);
    }

//------------------------Get FIR Details------------------------------------
    function getFirDetails(uint _id) public view returns(uint,uint,address,string memory,string memory,string memory){
        return(fir_data[_id].u_id,fir_data[_id].blocktime,fir_data[_id].user_address,fir_data[_id].fir_description,fir_data[_id].status, fir_data[_id].remark);
    }

//------------------------Get All FIR IDs-------------------------------------

    function getFirIDs() public view returns(uint[] memory){
        return fir_id;
    }

    function getPoliceAddress() public view returns(address[] memory){
        return police_address;
    }

//------------------------Get All FIR IDs-------------------------------------

}