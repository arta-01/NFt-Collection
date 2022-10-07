//SPDX-License-Identifier : MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721Enumerable ,Ownable {

uint256 public constant Max_Supply = 100; // NFT Max-Supply

 struct SaleConfig {
     bool saleStatus; // == false
     uint mintPrice;
 }

 SaleConfig public saleconfig;

 constructor() ERC721("Arta Collection" , "Arta"){
     saleconfig.mintPrice = 1 ether; // = 100000000000000000 Wei
 }

 function SetSaleStatus(bool _SaleStatus)public onlyOwner{
     saleconfig.saleStatus = _SaleStatus; //false or true

 }

function SetMintPrice(uint256 _mintprice) public onlyOwner{
    saleconfig.mintPrice = _mintprice; //Wei
    // for change NFT price
}

function mint(uint8 _amount) public payable{
     require(saleconfig.saleStatus , "Sale is not active ..!");
     require(totalSupply() < Max_Supply , "Sold out .!");
     require(totalSupply() + _amount <= Max_Supply , "please try to mint lower amount .!");
     require(msg.value >= _amount * saleconfig.mintPrice , "Value which you send is Wrong .!"); // check Price 

     for(uint256 i =1 ; i <= _amount ; i++){
         uint _id = totalSupply();
         _safeMint(msg.sender , _id);
     }
}

function withdraw() public onlyOwner{
    payable(msg.sender).transfer(address(this).balance);
}

} 
