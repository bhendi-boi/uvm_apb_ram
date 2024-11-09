# APB RAM verification with UVM

## Project structure

- run `clean.sh` to remove logs
- `deisgn.sv` has the design under test
- `testbench.sv` has the top module
- `*_test.sv` contain that particular test
- all sequences lie in `sequence.sv`

## Tests

- ### Write Read
  - Writes to a location and read from that location for all possible locations
  - Covers all address locations (from 0 to 31)
- ### Error
  - Generates a write and a read sequence with invalid address
- ### Random write
  - Writes to a random location
  - Use regression to hit all bins
