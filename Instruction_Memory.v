//============================
// Instruction_Memory.v
//============================
module Instruction_Memory(input rst,
                          input [31:0] A,
                          output [31:0] RD);

    reg [31:0] memory [0:255];

    initial begin
        
            $readmemh("instructions.mem", memory);
      
    end

    assign RD = memory[A[9:2]]; // word-aligned access (ignores bottom 2 bits)

endmodule
