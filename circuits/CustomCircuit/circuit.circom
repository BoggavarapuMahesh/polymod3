pragma circom 2.0.0;

/* This circuit template verifies if 'c' results from the multiplication of 'a' and 'b'. */

// Template for the Multiplier2 circuit
template Multiplier2 () {
    signal input a;
    signal input b;
    signal intermediateX;
    signal intermediateY;
    signal output isProductValid;

    // Instantiating logical gate components
    component andGate = AND();
    component orGate = OR();
    component notGate = NOT();

    // Connecting input and output signals
    andGate.a <== a;
    andGate.b <== b;
    intermediateX <== andGate.out;

    notGate.a <== b;
    intermediateY <== notGate.out;

    orGate.a <== intermediateX;
    orGate.b <== intermediateY;
    isProductValid <== orGate.out;
}

// Template for the NOT gate
template NOT() {
    signal input a;
    signal output out;

    // Applying logical NOT operation
    out <== 1 + a - 2 * a;
}

// Template for the AND gate
template AND() {
    signal input a;
    signal input b;
    signal output out;

    // Applying logical AND operation
    out <== a * b;
}

// Template for the OR gate
template OR() {
    signal input a;
    signal input b;
    signal output out;

    // Applying logical OR operation
    out <== a + b - a * b;
}

// Main component instantiating the Multiplier2 template
component main = Multiplier2();
