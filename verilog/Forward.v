module Forward(

	//MODULE INPUTS
		input [31:0] Instruction_IN

	//MODULE OUTPUTS
		



);

wire [5:0]	Opcode;
wire [25:0]	Index;
wire [4:0]     	RegisterRS;    
wire [4:0]      RegisterRT;
wire [4:0]     	RegisterRD;
wire [15:0]    	Immediate;
wire [4:0]	ShiftAmount;

assign 	Opcode 		= Instruction_IN[31:26];
assign 	Index		= Instruction_IN[25:0];
assign 	RegisterRS 	= Instruction_IN[25:21];
assign 	RegisterRT 	= Instruction_IN[20:16];
assign 	RegisterRD 	= Instruction_IN[15:11];
assign 	Immediate 	= Instruction_IN[15:0];
assign 	ShiftAmount 	= Instruction_IN[10:6];

endmodule
