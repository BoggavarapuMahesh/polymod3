# polymod3
# zardkat 
A hardhat-circom template to generate zero-knowledge circuits, proofs, and solidity verifiers

Quick Start
Compile the CustomCircuit() circuit and verify it against a smart contract verifier

pragma circom 2.0.0;

/*This circuit template checks that c is the multiplication of a and b.*/  

template CustomCircuit () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;  
   signal output c;  

   // Constraints.  
   c <== a * b;  
}
component main = CustomCircuit();

**Circuit Template - Multiplication Check**

This circuit template checks whether `c` is the result of the multiplication of two input values `a` and `b`.

**Inputs:**
- `a`: Input signal representing the first value.
- `b`: Input signal representing the second value.

**Outputs:**
- `y`: Output signal indicating whether `c` is the multiplication of `a` and `b`.
  - If `y` is 1, it means `c = a * b`.
  - If `y` is 0, it means `c` is not equal to `a * b`.

**Sub-Circuit - AND:**
The `AND` sub-circuit takes two input signals, `a` and `b`, and performs a bitwise AND operation. The result is stored in the output signal `out`, which represents `a * b`.

**Sub-Circuit - NOT:**
The `NOT` sub-circuit takes a single input signal `in` and performs a bitwise NOT operation. The output signal `out` represents the negation of the input signal.

**Usage:**
1. Define your specific values for `a` and `b` as input signals.
2. Connect the `a` and `b` signals to the inputs of the `CustomCircuit`.
3. Compile and run the circuit using a compatible circom compiler.

**Example:**
To use the circuit with custom values for `a` and `b`:

```circom
include "CustomCircuit.circom";

signal input a;
signal input b;

// Set your custom values for 'a' and 'b'
a <== 5;
b <== 7;

// Run the circuit
component main = CustomCircuit();
```
