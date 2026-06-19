// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/interfaces/IERC20.sol";

contract StakingRewards {
   IERC20 immutable stakeToken;
   IERC20 immutable rewardToken;
   address public owner;
   uint public duration;//持续时间
   uint public finshTime;//结束时间
   uint public updateTime;//更新时间

   uint public rewardRate;//奖励速率（每秒给所有用户的奖励币，例如30秒后将30块奖励按一定比例分给若干用户）
   mapping(address => uint)  public balanceOf;//账户的质押金额
   uint public totalSupply;//总质押金额

   uint public globalStakeToRewar; //全局质押币兑奖励币的比例
   mapping(address => uint) public userStakeToRewarOf;//用户的质押币兑换奖励币的比例
   mapping(address => uint) public rewardsOf; //用户的奖励金额

   constructor(address stakeAddr,address rewardAddr,uint _duration) {
        stakeToken = IERC20(stakeAddr);
        rewardToken = IERC20(rewardAddr);
        duration = _duration;
        owner = msg.sender;
   } 

   modifier onlyOwner(address addr) {
        require(addr == owner, "not owner");
        _;
   }

   // 发生新的质押或提取时
   // 更新全局质押币兑换奖励币的比例（累加）；更新这个用户的已赚取奖励（累加）
   // 记录此次时间点用户的质押币兑奖励币的比例
   modifier updateStakeToReward(address account) {
        globalStakeToRewar  = calCurrentGlobalStakeToReward();
        updateTime = getLastEffectTime();
        if(account != address(0)) {
            rewardsOf[account] = earn(account);
            userStakeToRewarOf[account] = globalStakeToRewar;
        }
        _;
   }

    //计算赚取金额  上次计算出的赚取金额 + 质押金额 *（当前比例 - 上次的比例） 
   function earn(address account) public view returns(uint) {
        return rewardsOf[account] + 
        balanceOf[account] * (calCurrentGlobalStakeToReward() - userStakeToRewarOf[account]) / 1e18;
   }

    //计算当前全局质押币奖励比例
    // 旧比例 + 新比例
    // 新比例 =  = 时间段内总奖励额(奖励速率 * 时间差) / 总质押金额
   function calCurrentGlobalStakeToReward() public view returns(uint) {
        if (totalSupply == 0) return globalStakeToRewar;
        return globalStakeToRewar + (rewardRate * (getLastEffectTime() - updateTime) * 1e18) / totalSupply;
   }

   // 获取奖励最后的有效时间点
   function getLastEffectTime() internal view returns(uint) {
        return block.timestamp < finshTime ? block.timestamp : finshTime;
   }

    // 设置新的奖励金额，并更新奖励速率和结束时间
    // - 如果当前时间超过上一个奖励周期结束时间(`finishAt`)时，创建一个全新的奖励周期
    // - 如果当前时间还在上一个奖励周期内时，将剩余奖励与新奖励合并计算新的分配速率
    // - 更新奖励结束时间(`finishAt`)为当前时间加上持续时间(`duration`)
   function setNewRewardAmount( uint amount) external onlyOwner(msg.sender){
        if(block.timestamp > finshTime) {
            rewardRate = amount / duration;
        } else {
            uint remainingRewards  =  rewardRate * (finshTime - block.timestamp);
            rewardRate = (amount + remainingRewards) / duration;
        }
        updateTime = block.timestamp;
        finshTime = block.timestamp + duration;
   } 
    //质押
   function stake(uint amount) external updateStakeToReward(msg.sender){
        require(amount > 0, "amount < 0");
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        stakeToken.transferFrom(msg.sender, address(this), amount); 
   }
    //撤销质押
    function unstake(uint amount) external updateStakeToReward(msg.sender){
        require(amount > 0, "amount < 0");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        stakeToken.transfer(msg.sender, amount);
   }

   //提取奖励
   function claim() external updateStakeToReward(msg.sender) {
        uint amount = earn(msg.sender);
        if(amount > 0){
            rewardsOf[msg.sender] = 0;
            rewardToken.transfer(msg.sender, amount);
        }
   }
}