module Forward(

	//MODULE INPUTS
		input [31:0] Instruction_IN,
		input [4:0]  EXMEM_RegD,
		input [4:0]  MEMWB_RegD,
		input [31:0] EXMEM_RegD_Value,
		input [31:0] MEMWB_RegD_Value,
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
		Forward_A = EXMEM_RegD_Value;
	end
	// EXEMEM RD == IDEX RT
	if(EXMEM_Rd == RegisterRT)begin
		Forward_B = EXMEM_RegD_Value;
	end
	// MEMWB RD == IDEX RS
	if(MEMWB_Rd == RegisterRS)begin
		Forward_A = MEMWB_RegD_Value;
	end
	// MEMWB RD == IDEX RT
	if(MEMWB_Rd == RegisterRT)begin
		Forward_B = MEMWB_RegD_Value;
	end
end


endmodule
