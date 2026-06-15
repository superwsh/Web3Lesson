// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IERC721 {
    function transferFrom(address from, address to, uint256 nftId) external;
}

// 荷兰拍卖，亦称“减价拍卖”，是一种独特的拍卖形式。与传统的拍卖不同，价格是从一个较高的起始价格开始，
// 并随着时间的推移逐渐下降，直到有买家愿意接受当前的价格，则拍卖结束。
contract DutchAuction {
    //NFT相关信息
    IERC721 immutable nft;
    uint immutable nftId;

    //拍卖信息
    address public seller;
    uint private constant DURATION = 7 days;
    uint public immutable startPrice;
    uint public immutable startTime;
    uint public immutable endTime;
    uint public constant discountRate = 1;

    constructor(uint _startPrice, address nftAddr, uint _nftId) {
        seller = msg.sender;
        nft = IERC721(nftAddr);
        nftId = _nftId;
        startPrice = _startPrice;
        startTime = block.timestamp;
        endTime = block.timestamp + DURATION;
        require(_startPrice >= discountRate * DURATION, "starting price <discount");
    }

    function buy() external payable returns(bool) {
        require(block.timestamp < endTime,"auction expired");
        uint price = getPrice();
        require(msg.value > price,"ETH < price");
        nft.transferFrom(seller, msg.sender, nftId);
        uint refund = msg.value - price;
        require(refund > 0 ,"ETH is not enough");
        (bool success,) = payable (msg.sender).call{value: refund}("");
        return success;
    }

    function getPrice() public view returns(uint) {
        uint timeElapsed = block.timestamp - startTime;
        uint discount = discountRate * timeElapsed;
        return startPrice - discount;
    }
}