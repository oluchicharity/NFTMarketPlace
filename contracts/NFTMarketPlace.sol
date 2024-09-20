pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarketplace is ERC721URIStorage, Ownable {
    struct NFT {
        uint256 id;
        uint256 price;
        bool isListed;
    }

    mapping(uint256 => NFT) public nfts;
    uint256 public nftCount;

    event NFTMinted(uint256 indexed id, string uri, address indexed owner);
    event NFTListed(uint256 indexed id, uint256 price);
    event NFTSold(uint256 indexed id, address indexed buyer, uint256 price);
    event NFTUnlisted(uint256 indexed id);

    constructor() ERC721("FriendlyNFTMarketplace", "FNFT") {}

    function mintNFT(string memory _uri) external onlyOwner {
        nftCount++;
        _mint(msg.sender, nftCount);
        _setTokenURI(nftCount, _uri);
        emit NFTMinted(nftCount, _uri, msg.sender);
    }

    function listNFT(uint256 _id, uint256 _price) external {
        require(ownerOf(_id) == msg.sender, "You need to own this NFT to list it.");
        require(_price > 0, "Price must be greater than zero.");

        nfts[_id] = NFT(_id, _price, true);
        emit NFTListed(_id, _price);
    }

    function buyNFT(uint256 _id) external payable {
        require(nfts[_id].isListed, "This NFT is not for sale.");
        require(msg.value >= nfts[_id].price, "Not enough funds to buy this NFT.");

        address seller = ownerOf(_id);
        require(seller != msg.sender, "You cannot buy your own NFT.");

        nfts[_id].isListed = false;

        _transfer(seller, msg.sender, _id);

        (bool success, ) = payable(seller).call{value: nfts[_id].price}("");
        require(success, "Transfer failed.");

        if (msg.value > nfts[_id].price) {
            (success, ) = payable(msg.sender).call{value: msg.value - nfts[_id].price}("");
            require(success, "Refund failed.");
        }

        emit NFTSold(_id, msg.sender, nfts[_id].price);
    }

    function unlistNFT(uint256 _id) external {
        require(ownerOf(_id) == msg.sender, "You need to own this NFT to unlist it.");
        require(nfts[_id].isListed, "This NFT is not currently listed.");

        nfts[_id].isListed = false;
        emit NFTUnlisted(_id);
    }

    function transferNFT(uint256 _id, address _to) external {
        require(ownerOf(_id) == msg.sender, "You need to own this NFT to transfer it.");
        require(_to != address(0), "Invalid address.");

        _transfer(msg.sender, _to, _id);
    }
}