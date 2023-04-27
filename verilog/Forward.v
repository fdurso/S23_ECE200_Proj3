module Forward(

	//MODULE INPUTS
		input [31:0] Instruction_IN,
		input [4:0]  EXMEM_RegD,
		input [4:0]  MEMWB_RegD,
		input 			 MEMWB_WriteEnable,
		input        CLOCK,

	//MODULE OUTPUTS
		output [31:0] Forward_A,
		output [31:0] Forward_B
);

wire [4:0]     	RegisterRS;
wire [4:0]      RegisterRT;
wire [4:0]		EXMEM_Rd;
wire [4:0]		MEMWB_Rd;

assign 	RegisterRS 	= Instruction_IN[25:21];
assign 	RegisterRT 	= Instruction_IN[20:16];
assign  EXMEM_Rd    = EXMEM_RegD;
assign  MEMWB_Rd    = MEMWB_RegD;


always @(posedge CLOCK) begin

	// EXMEM RD == IDEX RS
	if(EXMEM_Rd == RegisterRS)begin
		Forward_A = 2'b10;
	end
	// EXEMEM RD == IDEX RT
	else if(EXMEM_Rd == RegisterRT)begin
		Forward_B = 2'b10;
	end
	// MEMWB RD == IDEX RS
	else if(MEMWB_Rd == RegisterRS)begin
		Forward_A = 2'b01;
	end
	// MEMWB RD == IDEX RT
	else if(MEMWB_Rd == RegisterRT)begin
		Forward_B = 2'b01;
	end
	else begin
		Forward_A = 2'b00;
		Forward_B = 2'b00;
	end
end


endmodule
