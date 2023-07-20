pragma circom 2.0.0;

/*This circuit template checks that c is the multiplication of a and b.*/  

template CustomCircuit () {  
   signal input a;
   signal input b;
   signal x;
   signal output y;
   component andGate = AND();
   component notGate = NOT();
   andGate.a <== a;
   andGate.b <== b;
   x <== andGate.out;
   notGate.in <==x;
   
   y <== notGate.out;
   
}
template AND() {
    signal input a;
    signal input b;
    signal output out;

    out <== a*b;
}
template NOT() {
    signal input in;
    signal output out;

    out <== 1 + in - 2*in;
}

component main = CustomCircuit();
