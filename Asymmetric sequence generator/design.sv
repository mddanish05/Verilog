// Code your design here
module sequence_;
  reg clock;
  task inti_sequence; // initialize the sequence
    clock =1'b0;
  endtask
  // task to generate asymmetric sequence
  task asymmetric_sequence;
    begin
      #1 clock =1'b1;
      #10 clock =1'b0;
      #30 clock =1'b1;
      #1 clock=1'b0;
      end
  endtask
  initial
    begin
      inti_sequence;
    end
  always
    begin
      asymmetric_sequence;
    end
  initial
    begin
      #200 $finish;
    end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  endmodule
