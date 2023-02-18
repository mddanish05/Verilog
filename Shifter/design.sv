// Code your design here
module shifter;
  `define LEFT_SHIFT 1'b0
  `define RIGHT_SHIFT 1'b1
  reg [31:0] addr,left_addr,right_addr;
  function [31:0] shift(input [31:0] address,input control);
    shift=(control==`LEFT_SHIFT)?(address<<1):(address>>1);
  endfunction
  
  always@(addr)
    begin
      left_addr=shift(addr,`LEFT_SHIFT);
      $display($time," left_addr=%0b",left_addr);
      right_addr=shift(addr,`RIGHT_SHIFT);
      $display($time," right_addr=%0b",right_addr);
    end
  initial
    begin
      addr=32'd7;
      #1 addr=32'd3;
    end
  
endmodule
