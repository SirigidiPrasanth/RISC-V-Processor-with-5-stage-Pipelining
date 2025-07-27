module tb();

// Declare io
reg clk=0,rst, PCSrE;
reg [31:0] PCTargetE;
wire [31:0] InstrD , PCD, PCPlus4D;
//declare the dut
 fetch_cycle dut (  .clk(clk),
                    .rst(rst), 
                    .PCSrE( PCSrE), 
                    .PCTargetE(PCTargetE), 
                    .InstrD(InstrD), 
                    .PCD(PCD), 
                    .PCPlus4D(PCPlus4D)
					);

// clock generation
always begin
clk=~clk;
#50;
end

// provide stimulus ti design

initial begin
    rst<= 1'b0;
	#200;
	rst<=1'b1;
	PCSrE<= 1'b0;
	PCTargetE<= 32'h00000000;
	#500;
	$finish;

end




endmodule