// This circuit template checks if the sum of two inputs, a and b, is less than or equal to a threshold.

template MyCustomCircuit() {
    signal input a;
    signal input b;
    signal output result;
    signal threshold;

    // Choose the threshold value (e.g., 10)
    threshold <== 10;

    // Define the comparison circuit
// template AND() {
    signal input a;
    signal input b;
    signal output out;

    out <== a*b;
}
template NOT() {
    signal input in;
    signal output out;

    out <== 1 + in - 2*in;
} //


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
