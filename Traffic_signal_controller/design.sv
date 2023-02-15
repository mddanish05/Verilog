
`define TRUE 1'b1
`define FALSE 1'b0

//Delays 
`define Y2RDELAY 3 // yellow to red delay
`define R2GDELAY 2 // Red to green delay
module Traffic_signal_controller(hwy,cntry,X,clear,clock); //hwy =highway ,cntry=country road
  output reg [1:0] hwy,cntry; // 2 bit output for 3 states of signal(red ,yellow ,green)
  input X;// IF X=1 (True ) indicates that there is  car on the country road otherwise False
  input clock ,clear;
  parameter RED=2'd0,YELLOW=2'd1,GREEN=2'd2;
  
 // States defination    hwy           cntry
  parameter S0=3'd0, // Green 			Red
            S1=3'd1, // Yellow   		Red
            S2=3'd2, //  REd  			Red
  			    S3=3'd3, //  Red 			Green
  			    S4=3'd4; //  Red    		Yellow
  //internal state variable
  reg [2:0] state;
  reg [2:0] next_state;
  
 // state changes only at positive edge of clock
  always@(posedge clock)
    begin
      if(clear)
        state<=S0; //controller starts in S0 state
      else 
        state <=next_state; // state change
    end
  // compute the values of main signal and country signal
  always@(state)
    begin
      hwy=GREEN;
	  cntry=RED;
      case(state)
        S0: ; // No change use default
        S1:hwy=YELLOW;
        S2:hwy=RED;
        S3:begin
           hwy=RED;
           cntry=GREEN;
           end
        S4:begin
          hwy=RED;
          cntry=YELLOW;
        end
      endcase
    end
  // state machine using case statements
  always@(state or X)
    begin
      case(state)
        S0:if(X)
          next_state=S1;
         else
           next_state=S0;
        S1:begin 
          repeat(`Y2RDELAY)@(posedge clock);
          next_state=S2;
        end
        S2:begin // delay some positive edges of clock
          repeat(`R2GDELAY)@(posedge clock);
          next_state=S3;
        end
        S3:if(X)
          next_state=S3;
          else
            next_state=S4;
        S4:begin 
          repeat(`Y2RDELAY)@(posedge clock);
          next_state=S0;
        end
        default:next_state=S0;    
      endcase
    end
  
endmodule
