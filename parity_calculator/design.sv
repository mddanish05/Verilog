
module parity_calculate;
  reg [31:0] addr;
  reg parity;
  initial
    begin
      addr=32'd2;
      #4 addr=32'd30;
    end
  function calc_parity(input [31:0] address);
    calc_parity=^address;
  endfunction
  
  always@(addr)
    begin
      parity=calc_parity(addr);
      $display($time,"\t Parity calculated=%b",parity);
    //  $display($time,"\t Parity calculated=%b",calc_parity(addr));
    end
endmodule
