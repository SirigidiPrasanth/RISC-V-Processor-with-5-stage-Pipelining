//============================
// Fetch_cycle.v (Top module)
//============================
module fetch_cycle(clk, rst, PCSrE, PCTargetE, InstrD, PCD, PCPlus4D);

    input clk, rst;
    input PCSrE;
    input [31:0] PCTargetE;
    output [31:0] InstrD;
    output [31:0] PCD, PCPlus4D;

    wire [31:0] PC_F, PCF, PCPlus4F;
    wire [31:0] InstrF;

    reg [31:0] InstrF_reg;
    reg [31:0] PCF_reg, PCPlus4F_reg;

    // PC MUX
    Mux PC_MUX(
        .a(PCPlus4F),
        .b(PCTargetE),
        .s(PCSrE),
        .c(PC_F)
    );

    // PC Module
    PC_Module Program_Counter(
        .clk(clk),
        .rst(rst),
        .PC(PCF),
        .PC_Next(PC_F)
    );

    // Instruction Memory
    Instruction_Memory IMEM(
        .rst(rst),
        .A(PCF),
        .RD(InstrF)
    );

    // PC Adder
    PC_Adder PC_adder(
        .a(PCF),
        .b(32'h00000004),
        .c(PCPlus4F)
    ); // ? Fixed: missing semicolon added

    // Pipeline registers
    always @(posedge clk) begin
        if (!rst) begin
            InstrF_reg <= 0;
            PCF_reg <= 0;
            PCPlus4F_reg <= 0;
        end else begin
            InstrF_reg <= InstrF;
            PCF_reg <= PCF;
            PCPlus4F_reg <= PCPlus4F;
        end
    end

    assign InstrD = InstrF_reg;
    assign PCD = PCF_reg;
    assign PCPlus4D = PCPlus4F_reg;

endmodule
