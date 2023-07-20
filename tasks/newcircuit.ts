import { ethers } from "hardhat";
import { task } from "hardhat/config";
import { CircomCircuitConfig } from "hardhat-circom";
import fs from "fs";

const CONFIG_PATH = `${process.env.BASE_PATH}/circuits.config.json`;
const DIR_PATH = `${process.env.BASE_PATH}/circuits/`;

task("newcircuit", "Generate config for a new circuit")
  .addParam("name", "Name of the circuit")
  .setAction(async (taskArgs, hre) => {
    const circuitsConfig: CircomCircuitConfig[] = [];

    // Check if the configuration file exists, read it if present
    if (fs.existsSync(CONFIG_PATH)) {
      const configContent = fs.readFileSync(CONFIG_PATH, "utf8");
      if (configContent) {
        const existingConfigs = JSON.parse(configContent);
        if (Array.isArray(existingConfigs)) {
          circuitsConfig.push(...existingConfigs);
        }
      }
    }

    // Create a new circuit directory and files
    try {
      const circuitDirPath = `${DIR_PATH}${taskArgs.name}`;
      if (!fs.existsSync(circuitDirPath)) {
        fs.mkdirSync(circuitDirPath);
        fs.writeFileSync(`${circuitDirPath}/input.json`, "{}");
        fs.writeFileSync(`${circuitDirPath}/circuit.circom`, "");
      }
    } catch (err) {
      console.error("Failed to create the circuit directory:", err);
      return;
    }

    // Create a new circuit configuration
    const circuitConfig: CircomCircuitConfig = {
      name: taskArgs.name,
      version: 2,
      protocol: "groth16",
      circuit: `${taskArgs.name}/circuit.circom`,
      input: `${taskArgs.name}/input.json`,
      wasm: `${taskArgs.name}/out/circuit.wasm`,
      zkey: `${taskArgs.name}/out/${taskArgs.name}.zkey`,
      vkey: `${taskArgs.name}/out/${taskArgs.name}.vkey`,
      r1cs: `${taskArgs.name}/out/${taskArgs.name}.r1cs`,
      beacon: "0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f",
    };

    // Add the new circuit config to the array
    circuitsConfig.push(circuitConfig);

    // Write the updated configurations to the file
    fs.writeFileSync(CONFIG_PATH, JSON.stringify(circuitsConfig, null, 2));
});
