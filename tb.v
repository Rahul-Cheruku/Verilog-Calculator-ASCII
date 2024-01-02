// Testbench
module tb;

  reg clk;
  reg [7:0] data;
  reg start;
  reg [7:0] file_data;
  reg [255:0] out;
  integer file;
  
  // Instantiate calculator
  calculator uut (
    .data(data),
    .out0(out),
    .clk(clk)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Stimulus generation
  initial begin
    clk = 0;
    start = 1;
    file = $fopen("C:/Users/rahul/Desktop/input.txt", "r");
    end
    
    always @ (posedge clk)
    begin
    $fscanf(file, "%c", file_data);
    if (!$feof(file)) begin
        // Read data from file
        data = file_data;
        end
    else begin
        data = "=";
        @ (posedge clk) begin
        $fclose(file);
        $stop;
        end
        end
    end

endmodule
