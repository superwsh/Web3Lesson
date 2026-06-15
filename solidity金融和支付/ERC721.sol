// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns(bool);
}
interface IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function transferFrom(address from, address to, uint256 tokenId) external;
    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address operator);
    function setApprovalForAll(address operator, bool _approved) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;
}

interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
}

contract ERC721 is IERC721 {
    mapping(uint256 => address) internal  _owners;//每个NFT的拥有者
    mapping(address => uint256) internal _balances;//每个地址拥有的NFT数量
    mapping(uint256 => address) internal _tokenApprovals; //NFT的批准地址
    mapping(address => mapping(address => bool)) private isApproveForOperator;//地址对所有操作者的批准

    function supportsInterface(bytes4 interfaceId) external pure returns(bool) {
        return interfaceId == type(IERC721).interfaceId || interfaceId == type(IERC165).interfaceId ;
    }

    function balanceOf(address owner) external view returns (uint256 balance) {
        require(owner != address(0),"invalid address");
        return _balances[owner];
    }
    function ownerOf(uint256 tokenId) external view returns (address owner) {
        return _owners[tokenId];
    }

    function transferFrom(address from, address to, uint256 tokenId) public  {
        require(from == _owners[tokenId]);
        require(isApprovedOrOwner(from, msg.sender, tokenId),"not authorized"); //判断当前调用者是否被授权
        _balances[from] --;
        _balances[to] ++;
        _owners[tokenId] = to;
        delete _tokenApprovals[tokenId];
        emit Transfer(from, to, tokenId);
    }
    //判断消费者是否有权限
    function isApprovedOrOwner(address owner,address spender,uint tokenId) internal view returns (bool) {
        return owner == spender || isApproveForOperator[owner][spender] || _tokenApprovals[tokenId] == spender;
    }
    //授权
    function approve(address spender, uint256 tokenId) external {
        address owner = _owners[tokenId];
        require(owner == msg.sender || isApproveForOperator[owner][msg.sender],"not authorized");
        _tokenApprovals[tokenId] = spender;
        isApproveForOperator[msg.sender][spender] = true;
        emit Approval(msg.sender, spender, tokenId);
    }
    function getApproved(uint256 tokenId) external view returns (address operator) {
        return _tokenApprovals[tokenId];
    }
    function setApprovalForAll(address operator, bool _approved) external {
        isApproveForOperator[msg.sender][operator] = _approved;
    }
    function isApprovedForAll(address owner, address operator) external view returns (bool) {
        return isApproveForOperator[owner][operator];
    }
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external {
        require(to.code.length == 0 || 
        IERC721Receiver(to).onERC721Received(from,to,tokenId,data) == IERC721Receiver.onERC721Received.selector,"unsafe recipient");
        transferFrom(from,to,tokenId);
    }
}

contract MyNFT is ERC721{
    function mint(address to,uint tokenId) external {
        _balances[to] += 1;
        _owners[tokenId] = to;
    }

    function burn(uint tokenId) external {
        address owner = _owners[tokenId];
        _balances[owner] -= 1;
        delete _owners[tokenId];
        delete _tokenApprovals[tokenId];
    }
}