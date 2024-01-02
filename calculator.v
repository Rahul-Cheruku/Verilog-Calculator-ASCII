`timescale 1ns / 1ps


module calculator(
   data,
   out0,
   clk
);
input clk;
input [7:0] data;
output reg [255:0] out0;

//parameter start = 4'd0;
//parameter v0 = 4'd1;
//parameter o0 = 4'd2;
//parameter bs1 = 4'd3;
//parameter v1 = 4'd4;
//parameter o1 = 4'd5;
//parameter be1 = 4'd6;
//parameter bs2 = 4'd7;
//parameter v2 = 4'd8;
//parameter o2 = 4'd9;
//parameter be2 = 4'd10;
//parameter bs3 = 4'd11;
//parameter v3 = 4'd12;
//parameter o3 = 4'd13;
//parameter be3 = 4'd14;
//parameter Evaluate = 4'd15;

//parameter add = 4'd0;
//parameter sub = 4'd1;
//parameter mul = 4'd2;
//parameter div = 4'd3;

reg [2:0][255:0] stack0;
reg [2:0][255:0] stack1;
reg [2:0][255:0] stack2;
reg [2:0][255:0] stack3;

reg [1:0] state_level;
reg [15:0] out3;
reg [15:0] out2;
reg [15:0] out1;
reg [15:0] out0;

initial begin 
state_level = 0;
out0 = 'bx;
out1 = 'bx;
out2 = 'bx;
out3 = 'bx;
stack0[0] = 'bx;
stack0[1] = 'bx;
stack0[2] = 'bx;
stack1[0] = 'bx;
stack1[1] = 'bx;
stack1[2] = 'bx;
stack2[0] = 'bx;
stack2[1] = 'bx;
stack2[2] = 'bx;
stack3[0] = 'bx;
stack3[1] = 'bx;
stack3[2] = 'bx;

end


  // Display incoming data
  always @(data) begin
  $display("Incoming Data: %c", data);
  end
  
  always @(data or (posedge clk)) begin
  
  case(data)
  "0", "1", "2", "3","4","5","6","7","8","9" : begin 
  if(state_level == 0) begin 
    if(stack0[0] === 'bx) begin stack0[0] = atoi(data); end
    else begin stack0[1] = atoi(data); end
  end 
  
  else if(state_level === 2'b1) begin
  if(stack1[0] === 'bx) begin stack1[0] = atoi(data);  end
    else begin stack1[1] = atoi(data); end
  end
  
  else if(state_level === 2'b10) begin
  if(stack2[0] === 'bx) begin stack2[0] = atoi(data);  end
    else begin stack2[1] = atoi(data); end
  end
 
  else begin 
  if(stack3[0] === 'bx) stack3[0] = atoi(data); 
    else stack3[1] = atoi(data);  
  end
  end
  
  "(": begin 
  if(state_level <= 2'd3) begin 
    state_level = state_level + 1;
  end 
  end 
  
  ")": begin 
  if(state_level <= 2'd3) begin 
    state_level = state_level - 1;
  end 
  end
  
  "*" : begin 
  // calling task 
  record_instruction(data);
  end
  
  "+" : begin 
  record_instruction(data);
  end
  
  "-" : begin 
  record_instruction(data);
  end
  
  "/" : begin 
  record_instruction(data);
  end
  
  "=" : begin 
    // D-DAY
    
    $display("data stack0: %d", stack0[0]);
    $display("data stack0: %d", stack0[1]);
    $display("data stack0: %d", stack0[2]);
    $display("data stack1: %d", stack1[0]);
    $display("data stack1: %d", stack1[1]);
    $display("data stack1: %d", stack1[2]);
    $display("data stack2: %d", stack2[0]);
    $display("data stack2: %d", stack2[1]);
    $display("data stack2: %d", stack2[2]);
    $display("data stack3: %d", stack3[0]);
    $display("data stack3: %d", stack3[1]);
    $display("data stack3: %d", stack3[2]);
   

    
    if(!(stack3[0] === 'bx)) begin 
        $display("invoked stack3");

        out3 = perform_operation(stack3);
            if(!(stack2[0] === 'bx)) begin
                stack2[1] = out3;
                out2 = perform_operation(stack2);
            end
            else begin 
                stack2[0] = out3;
                out2 = perform_operation(stack2);
            end 
            if(!(stack1[0] === 'bx)) begin
                stack1[1] = out2;
                out1 = perform_operation(stack1);
            end
            else begin 
                stack1[0] = out2;
                out1 = perform_operation(stack2);
            end
            if(!(stack0[0] === 'bx)) begin
                stack0[1] = out1;
                out0 = perform_operation(stack0);
            end
            else begin 
                stack0[0] = out1;
                out0 = perform_operation(stack2);
            end
    end
    
    
    
    
    // from lvl 2
    else if(!(stack2[0] === 'bx)) begin 
    $display("invoked stack2");
    out2 = perform_operation(stack2);
            if(!(stack1[0] === 'bx)) begin
                stack1[1] = out2;
                out1 = perform_operation(stack1);
            end
            else begin 
                stack1[0] = out2;
                out1 = perform_operation(stack2);
            end
            if(!(stack0[0] === 'bx)) begin
                stack0[1] = out1;
                out0 = perform_operation(stack0);
            end
            else begin 
                stack0[0] = out1;
                out0 = perform_operation(stack2);
            end   
    end
    
    
    
    
    else if(!(stack1[0] === 'bx)) begin
    $display("invoked stack1");
    out1 = perform_operation(stack1);
        if(!(stack0[0] === 'bx)) begin
            stack0[1] = out1;
            out0 = perform_operation(stack0);
        end
        else begin 
            stack0[0] = out1;
            out0 = perform_operation(stack2);
        end
    end
    
    else if(!(stack0[0] === 'bx)) begin $display("invoked stack0"); out0 = perform_operation(stack0); end
    else out0 = 16'bx;
    $display("final answer: %d", out0);
  end
  endcase
  end
  
 

  function logic [15:0] perform_operation;
    input [2:0][255:0] stack;
    
    automatic logic  [255:0] operand1 = stack[0];
    automatic logic [255:0] operand2 = stack[1];
    automatic logic [255:0]  operator = stack[2];
    $display("calculator invoked");
    $display("op1 %d:", operand1);
    $display("op2 %d:", operand1);
    $display("operator %d:", operator);

    if ((!(operator === 'bx))&&(!(operand1 === 'bx))&&(!(operand2 === 'bx)) ) begin
    case (operator)
      'b0: perform_operation = operand1 + operand2; // Addition
      'b1: perform_operation = operand1 - operand2; // Subtraction
      'b10: perform_operation = operand1 * operand2; // Multiplication
      'b11: perform_operation = operand1 / operand2; // Division
      default: perform_operation = 'bx; // Default case (undefined operation)
    endcase end
    else if(!(operand1 === 'bx)) perform_operation = operand1;
    else perform_operation = operand2;
    
    $display("calculated %d:", perform_operation);

    
  endfunction
  
  function logic [7:0] atoi;
    input logic [7:0] ascii_char;
    reg [7:0] value;
    case (ascii_char)
    
      "0": value = 8'b0000_0000;
      "1": value = 8'b0000_0001;
      "2": value = 8'b0000_0010;
      "3" : value = 8'b0000_0011;
      "4" : value = 8'b0000_0100;
      "5" : value = 8'b0000_0101;
      "6" : value = 8'b0000_0110;
      "7" : value = 8'b0000_0111;
      "8" : value = 8'b0000_1000;
      "9" : value = 8'b0000_1001;
      

      default: value = 8'b1111_1111; // Default case for non-supported characters
      
    endcase

    atoi = value;
  endfunction
  
  
    function logic [7:0] decode_ascii_instruction;
    input logic [7:0] ascii_char;
    reg [7:0] value;
    case (ascii_char)

      "+" : value = 8'b0;
      "-" : value = 8'b1;
      "*" : value = 8'b10;
      "/" : value = 8'b11;
      "=" : value = 8'd15;

      default: value = 4'b1111; // Default case for non-supported characters
      
    endcase

    decode_ascii_instruction = value;
  endfunction
  
  
  task record_instruction;
  input logic [7:0] data;
    begin
    $display("instructor invoked at state level: %d and data :%d", state_level, decode_ascii_instruction(data));
     if(state_level == 0) begin 
    if(stack0[2] === 'bx) begin $display("saving to stack0"); stack0[2] = decode_ascii_instruction(data);  end
  end 
  
  else if(state_level == 'd1) begin
    if(stack1[2] === 'bx) begin $display("saving to stack1"); stack1[2] = decode_ascii_instruction(data);  end
  end
  else if(state_level == 'd2) begin
  if(stack2[2] === 'bx) begin $display("saving to stack2"); stack2[2] = decode_ascii_instruction(data);  end
  end
  else begin if(stack3[2] === 'bx) begin $display("saving to stack3"); stack3[2] = decode_ascii_instruction(data);  end
  end
    end
  endtask
  
  
endmodule
