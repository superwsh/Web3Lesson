import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import hre from "hardhat";
import "@nomicfoundation/hardhat-ethers";

import { ethers } from "hardhat";


describe("Hello World", () => {
  it("should get the hello world", async () => {
    const HW = await ethers.getContractFactory("HelloWorld");
    const hello = await HW.deploy();

    expect(await hello.hello()).to.equal("Hello, World!");
  });
});
