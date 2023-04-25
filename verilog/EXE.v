module EXE(

	//MODULE INPUTS

		//CONTROL SIGNALS
		input CLOCK,
		input RESET,
		input [1:0] aSelect_IN, //select bits for the multiplexers from the forwarding unit
		input [1:0] bSelect_IN,

		//ID/EXE --> EXE
		input [31:0] 	OperandA_IN,
		input [31:0] 	OperandB_IN,
		input [5:0]  	ALUControl_IN,
		input [4:0]  	ShiftAmount_IN,



	//MODULE OUTPUT

		//EXE --> EXE/MEM
		output [31:0] 	ALUResult_OUT

);

reg [31:0] HI/*verilator public*/;
reg [31:0] LO/*verilator public*/;

wire [31:0] newHI;
wire [31:0] newLO;

wire [31:0] newOperandA, //outputs of multiplexers feeding ALU
wire [31:0] newOperandB,

always @(posedge CLOCK) begin
	case (aSelect_IN)
		2'b00: newOperandA <=  ;
		2'b01: newOperandA <=  ;
		2'b10: newOperandA <=  ;
		2'b11: newOperandA <=  ;
	endcase

	case (bSelect_IN)
		2'b00: newOperandB <=  ;
		2'b01: newOperandB <=  ;
		2'b10: newOperandB <=  ;
		2'b11: newOperandB <=  ;
	endcase
end

ALU ALU(

	//MODULE INPUTS
	.HI_IN(HI),
	.LO_IN(LO),
	.OperandA_IN(newOperandA),
	.OperandB_IN(newOperandB),
	.ALUControl_IN(ALUControl_IN),
	.ShiftAmount_IN(ShiftAmount_IN),

	//MODULE OUTPUTS
	.ALUResult_OUT(ALUResult_OUT),
	.HI_OUT(newHI),
	.LO_OUT(newLO)

);

//ON THE RISING EDGE OF THE CLOCK OR FALLING EDGE OF RESET
always @(posedge CLOCK or negedge RESET) begin

	//IF THE MODULE HAS BEEN RESET
	if(!RESET) begin

		HI <= 0;
		LO <= 0;

	//ELSE IF THE CLOCK HAS RISEN
	end else if(CLOCK) begin

		HI <= newHI;
		LO <= newLO;

		$display("");
		$display("----- EXE -----");
		$display("HI:\t%x", HI);
		$display("LO:\t%x", LO);

	end

end

endmodule
