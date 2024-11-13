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
- ### Random read
  - Reads from a random location
- ### Random Test
  - Includes 1024 random write transactions
  - Inlucdes 1024 random read transactions
  - Includes 2 error transactions (one for write and one for read)

