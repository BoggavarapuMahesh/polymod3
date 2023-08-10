
# Overview
The Multiplier Circuit, developed using Circom 2.0.0, is designed to confirm whether a given value 'c' is genuinely the product of two input factors 'a' and 'b'. The circuit employs a combination of logical AND, OR, and NOT gates to perform essential computations and comparisons.
# Introduction
The goal of the Multiplier Circuit is to ascertain the accuracy of multiplication results. By providing input values 'a' and 'b', the circuit assesses if the resulting value 'c' is indeed the product of the two inputs. This is achieved through a clever application of logical AND, OR, and NOT gates, each contributing to the circuit's overall functionality.
# Circuit Template Descriptions
Multiplier2
This template is the core of the Multiplication Verification Circuit. It accepts two input signals, 'a' and 'b', and performs calculations to generate intermediate values 'x' and 'y' using a combination of AND, NOT, and OR gates. Ultimately, it determines if the value 'c' is indeed the product of 'a' and 'b' by comparing the outputs of the OR gate.

NOT
The NOT gate template executes a logical NOT operation on an input signal 'a'. This simple yet pivotal operation is essential for the circuit's logical computations.

AND
The AND gate template implements a logical AND operation on two input signals, 'a' and 'b'. This logical gate is fundamental to the circuit's ability to perform necessary comparisons.

OR
The OR gate template executes a logical OR operation on two input signals, 'a' and 'b'. This gate is another crucial component that contributes to the logical evaluations within the circuit.

# Components
main: This component instantiates the 'Multiplier2' template, forming the complete circuit structure.
License
This project is open-source and licensed under the MIT License.
