# polymod3
# zardkat 
A hardhat-circom template to generate zero-knowledge circuits, proofs, and solidity verifiers

Quick Start
Compile the CustomCircuit() circuit and verify it against a smart contract verifier

pragma circom 2.0.0; 
// This circuit template checks if the sum of two inputs, a and b, is less than or equal to a threshold.

template MyCustomCircuit() {
    signal input a;
    signal input b;
    signal output result;
    signal threshold;

    // Choose the threshold value (e.g., 10)
    threshold <== 10;

    // Define the comparison circuit
    component comparison = LessThanOrEqual();
    comparison.a <== a + b;
    comparison.b <== threshold;
    result <== comparison.result;
}

template LessThanOrEqual() {
    signal input a;
    signal input b;
    signal output result;

    result <== a <= b ? 1 : 0;
}

component main = MyCustomCircuit();

**Circuit Template - Sum Comparison**

This circuit template checks if the sum of two inputs, `a` and `b`, is less than or equal to a threshold value. The template uses a sub-circuit named `LessThanOrEqual` to perform the comparison.

**Inputs:**
- `a`: Input signal representing the first value.
- `b`: Input signal representing the second value.

**Outputs:**
- `result`: Output signal indicating whether the sum of `a` and `b` is less than or equal to the threshold.

**Threshold:**
The threshold value is set to 10 by default. You can modify the threshold value in the `MyCustomCircuit` template to perform different comparisons.

**Sub-Circuit - LessThanOrEqual:**
The `LessThanOrEqual` sub-circuit compares two input signals, `a` and `b`, and sets the output signal `result` to 1 if `a` is less than or equal to `b`. Otherwise, the output signal is set to 0.

**Usage:**
1. Define your specific values for `a` and `b` as input signals.
2. Set the `threshold` value to the desired comparison threshold.
3. Run the circuit using a compatible circom compiler.

**Example:**
To run the circuit with custom values for `a` and `b`:

```circom
include "MyCustomCircuit.circom";

signal input a;
signal input b;

// Set your custom values for 'a' and 'b'
a <== 7;
b <== 3;

// Run the circuit
component main = MyCustomCircuit();
