// Code your testbench here
// or browse Examples
module tb;
  wire [1:0] hwy,cntry;
  reg clock,clear,X;
  Traffic_signal_controller DUT(.*);
  
  initial 
    begin
      clock= `FALSE;
      forever #5 clock=~clock;
    end
  initial
    begin
      #5 clear=`TRUE;
      #6 clear=`FALSE;
      #4 clear =`TRUE;
      #6 clear=`FALSE;
    end
 initial
   begin
     $monitor("time=%t clear=%b, X=%0b ,hwy=%b,cntry=%b",$time,clear,X,hwy,cntry);
   end
  initial
    begin
      #5 X=`TRUE;
      #100 X=`FALSE;
      #100 X=`TRUE;
      #100 $stop;
    end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end
endmodule
