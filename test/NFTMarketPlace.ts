// import { expect } from "chai";
// import { ethers } from "hardhat";
// //import { FriendlyNFTMarketplace } from "../typechain"; // Import the correct typechain type

// describe("NFTMarketplace", function () {
//   let marketplace: NFTMarketplace;
//   let owner: any;
//   let buyer: any;
//   let other: any;

//   beforeEach(async function () {
//     [owner, buyer, other] = await ethers.getSigners();
//     const Marketplace = await ethers.getContractFactory("FriendlyNFTMarketplace");
//     marketplace = (await Marketplace.deploy()) as NFTMarketplace;
//     await marketplace.deployed();
//   });

//   it("should mint an NFT", async function () {
//     await marketplace.connect(owner).mintNFT("tokenURI");
//     expect(await marketplace.ownerOf(1)).to.equal(owner.address);
//   });

//   it("should list an NFT", async function () {
//     await marketplace.connect(owner).mintNFT("tokenURI");
//     await marketplace.connect(owner).listNFT(1, ethers.parseEther("1"));
//     const nft = await marketplace.nfts(1);
//     expect(nft.isListed).to.equal(true);
//   });

//   it("should buy an NFT", async function () {
//     await marketplace.connect(owner).mintNFT("tokenURI");
//     await marketplace.connect(owner).listNFT(1, ethers.parseEther("1"));

//     await marketplace.connect(buyer).buyNFT(1, { value: ethers.parseEther("1") });

//     expect(await marketplace.ownerOf(1)).to.equal(buyer.address);
//   });
// });
