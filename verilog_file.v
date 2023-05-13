//1.    INVERTER CODE
module inverter(y,a);
    output y;
    input a;

    assign y=~a;

endmodule

//2. AND GATE CODE
module and_gate(y,a,b);
    output y;
    input a,b;

    assign y=a&b;

endmodule

//3. OR GATE CODE
module or_gate(y,a,b);
    output y;
    input a,b;

    assign y=a|b;

endmodule

//4. HALF ADDER CODE
module half_adder( a,b,sum,carry );
output sum ,carry;
input a ,b;
  
assign sum   = a ^ b;

assign carry = a & b;

endmodule


//5.    FULL ADDER CODE

module full_adder( a,b,cin,sum,carry );
output sum ,carry;
input a ,b ,cin;

assign sum   = a ^ b ^ cin;

assign carry = (a & b) | (b & cin) | (cin & a);

endmodule


// 6.   HALF SUBTRATOR  CODE

module half_substractor(a,b,difference,borrow);
output difference,borrow;
input a ,b;

assign difference   = a ^ b;
  
assign borrow = (~a) & b;

endmodule

// 7.   FULL SUBTRATOR  CODE
module full_substractor(a,b,cin,difference,borrow);
output difference ,borrow;
input a ,b ,bin;

assign sum   = a ^ b ^ bin;

assign carry = (~a & b) | (b & bin) | (~a & bin);

endmodule

// 8. D FLIP FLOP CODE
module dflipflop(q,qbar,clk,rst,d);
    output reg q;
    output qbar;
    input clk, rst;
    input d;

    assign qbar = ~q;

    always @(posedge clk)
    begin
        if (rst)
            q <= 0;
        else
            q <= d;
    end
endmodule

// 9. T FLIP FLOP CODE
module tflipflop(q,qbar,clk,rst,t);
    output reg q;
    output qbar;
    input clk, rst;
    input t;

    assign qbar = ~q;

    always @(posedge clk)
    begin
        if (rst)
            q <= 0;
        else
            case(t)
                1'b0: q <= q;
                1'b1: q <= ~q;
            endcase
    end
endmodule

// 10. TWO BIT MAGNITUDE COMPARATOR CODE
module mag_comp (A,B,ALTB,AGTB,AEQB);
input [3:0] A,B;
output ALTB,AGTB,AEQB;
assign ALTB = (A < B),
AGTB = (A > B),
AEQB = (A == B);
endmodule

