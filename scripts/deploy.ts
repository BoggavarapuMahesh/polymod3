import { ethers } from "hardhat";
import { BigNumber } from "ethers";

const fs = require("fs");
const snarkjs = require("snarkjs");

interface ICallData {
  pi_a: BigNumber[];
  pi_b: BigNumber[][];
  pi_c: BigNumber[];
  input: BigNumber[];
}

const CIRCUIT_PATH = "./circuits/MyCustomCircuit/";

function formatBigNumberArray(arr: BigNumberish[]): BigNumber[] {
  return arr.map((n) => BigNumber.from(n.toString()));
}

async function generateCallData(): Promise<ICallData> {
  const zkProof = await generateProof();

  const proof = zkProof.proof;
  const publicSignals = zkProof.publicSignals;

  const pi_a = formatBigNumberArray(proof.pi_a);
  const pi_b = proof.pi_b.map((row: BigNumberish[]) => formatBigNumberArray(row));
  const pi_c = formatBigNumberArray(proof.pi_c);
  const input = formatBigNumberArray(publicSignals);

  return { pi_a, pi_b, pi_c, input };
}

async function generateProof() {
  const inputData = fs.readFileSync(CIRCUIT_PATH + "input.json", "utf8");
  const input = JSON.parse(inputData);

  const out = await snarkjs.wtns.calculate(
    input,
    CIRCUIT_PATH + "out/circuit.wasm",
    CIRCUIT_PATH + "out/circuit.wtns"
  );

  const proof = await snarkjs.groth16.prove(
    CIRCUIT_PATH + "out/MyCustomCircuit.zkey",
    CIRCUIT_PATH + "out/circuit.wtns"
  );

  fs.writeFileSync(CIRCUIT_PATH + "out/proof.json", JSON.stringify(proof, null, 1));

  return proof;
}

async function main() {
  const Verifier = await ethers.getContractFactory("MyCustomCircuitVerifier");
  const verifier = await Verifier.deploy();
  await verifier.deployed();

  console.log(`Verifier deployed to ${verifier.address}`);

  const { pi_a, pi_b, pi_c, input } = await generateCallData();

  const tx = await verifier.verifyProof(pi_a, pi_b, pi_c, input);

  console.log(`Verifier result: ${tx}`);
  console.assert(tx == true, "Proof verification failed!");

  process.exit(0);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
