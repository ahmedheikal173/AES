# AES
Advanced Encryption Standard (10 Rounds)
For this project, I implemented the AES algorithm in Verilog to provide secure 
encryption and decryption of electronic data. The Verilog code was optimized to 
ensure fast and efficient processing of data blocks and keys.
The AES algorithm operates on a 128-bit block of data at a time, so I designed the 
Verilog code to process 16 bytes of data at once. This was accomplished by creating a 
4x4 matrix of bytes that were processed by a series of mathematical operations, 
including substitution, permutation, and mixing.
To encrypt or decrypt data, the Verilog code takes in a 128-bit key, which is expanded 
into a series of round keys using a key schedule. The round keys are then used in each 
round of the AES algorithm to transform the data block
