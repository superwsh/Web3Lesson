// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IERC721 {
    function transferFrom(address from, address to, uint256 nftId) external;
}

contract EnglishAuction {
    //NFT信息
    IERC721 immutable nft;
    uint public immutable nftId;

    //拍卖信息
    address payable public immutable  seller;
    uint public endTime;
    bool public started;
    bool public ended;
    address public higehestBidder;//最高竞价者
    uint public highestBid;//最高竞价
    mapping(address => uint) public bids;//每个人的竞价

    //初始化
    constructor(address _nft, uint _nftId,uint startBid) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable (msg.sender);
        endTime = block.timestamp + 6000;
        highestBid = startBid;
    }

    //卖家开始拍卖
    function start() external {
        require(msg.sender == seller,"not seller");
        require(!started,"already start");
        started = true;
        nft.transferFrom(seller, address(this), nftId);
    }

    //买家竞价
    function bid() external payable {
        require(started,"not start");
        require(block.timestamp < endTime,"already end");
        require(msg.value > highestBid,"value < highestBid");

        higehestBidder = msg.sender;
        highestBid = msg.value;
        bids[msg.sender] = msg.value;
    }

    //买家提款
    function withDraw() external returns(bool) {
        uint amount = bids[msg.sender];
        bids[msg.sender] = 0;
        (bool success,) = payable (msg.sender).call{value: amount}("");
        return success;
    }

    //结束拍卖
    function end() external {
        require(!ended,"alreay ended");
        if(higehestBidder != address(0)) {
            nft.transferFrom(address(this), higehestBidder, nftId);
            (bool success,) =  seller.call{value: highestBid}("");
            require(success,"end failed");
        } else {
            nft.transferFrom(address(this), seller, nftId);
        }
        ended = true;
    }
}