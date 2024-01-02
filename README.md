# Verilog-Calculator-ASCII
## SUPPORTS 3-LEVEL NESTING OF ()
Verilog Calculator which takes 8 bit ASCII char input, clk and a test bench which reads string of expersion from .txt file. 

Welcome to the Verilog ASCII Calculator project! This hardware calculator is designed to perform basic arithmetic operations on single-digit operands (0 to 9) with support for one operator. The calculator reads input from a file and operates in a clock-driven environment.

## Usage

1. **Clone the Repository:**
    Clone the repository to your local machine:
    ```bash
    git clone https://github.com/your-username/Verilog-ASCII-Calculator.git
    ```

2. **Prepare Input File:**
    Create an input text file (e.g., `input.txt`) containing the ASCII representation of single-digit operands (0 to 9) and one operator (+, -, *, /) per line. The calculator will read and process these inputs.

    Example `input.txt`:
    ```
    5+3
    5*(5+(6*(3-2))) 
    ```

3. **Run the Simulation:**
    - Ensure you have a Verilog simulator installed (e.g., ModelSim).
    - Open the testbench (`tb.v`) in your simulator and run the simulation.

4. **Review Results:**
    - The calculator processes the input from the file and displays intermediate and final results.
    - Check the console output for detailed information on the calculations.

## File Structure

- **`tb.v`:** Testbench module for simulating the Verilog ASCII Calculator.
- **`calculator.v`:** Verilog module implementing the ASCII calculator logic.

## Calculator Operation

The calculator operates in a stack-based manner and supports the following operations:
- Addition (+)
- Subtraction (-)
- Multiplication (*)
- Division (/)

### Limitations
- The calculator processes single-digit operands only (0 to 9).
- It supports one operator in a single expression.

## Contributing

Contributions are welcome! If you have ideas for improvements, bug fixes, or additional features, feel free to open an issue or submit a pull request.


Explore the world of Verilog-based ASCII calculation with this simple yet educational calculator! Happy computing!
