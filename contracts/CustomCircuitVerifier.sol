// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.11;

library Pairing {
    // ... (Library code remains unchanged in this paraphrased version)
}

contract MyVerifier {
    using Pairing for *;

    struct VerifyingKey {
        Pairing.G1Point alfa1;
        Pairing.G2Point beta2;
        Pairing.G2Point gamma2;
        Pairing.G2Point delta2;
        Pairing.G1Point[] IC;
    }

    struct Proof {
        Pairing.G1Point A;
        Pairing.G2Point B;
        Pairing.G1Point C;
    }

    function verifyingKey() internal pure returns (VerifyingKey memory vk) {
        // ... (Verifying key remains unchanged in this paraphrased version)
    }

    function verify(uint[] memory input, Proof memory proof) internal view returns (bool) {
        // ... (Verification logic remains unchanged in this paraphrased version)
    }

    // Function to verify the SNARK proof
    function verifyProof(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[1] memory input
    ) public view returns (bool) {
        Proof memory proof;
        proof.A = Pairing.G1Point(a[0], a[1]);
        proof.B = Pairing.G2Point([b[0][0], b[0][1]], [b[1][0], b[1][1]]);
        proof.C = Pairing.G1Point(c[0], c[1]);
        uint[] memory inputValues = new uint[](input.length);
        for (uint i = 0; i < input.length; i++) {
            inputValues[i] = input[i];
        }
        return verify(inputValues, proof);
    }

    // Function to add a new point to the verifying key's IC array
    function addToIC(Pairing.G1Point memory pointToAdd) public {
        VerifyingKey storage vk = verifyingKey();
        vk.IC.push(pointToAdd);
    }

    // Function to remove a point from the verifying key's IC array
    function removeFromIC(uint index) public {
        VerifyingKey storage vk = verifyingKey();
        require(index < vk.IC.length, "Invalid index");
        for (uint i = index; i < vk.IC.length - 1; i++) {
            vk.IC[i] = vk.IC[i + 1];
        }
        vk.IC.pop();
    }
}
