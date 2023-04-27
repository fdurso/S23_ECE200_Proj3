module Hazard(

	//MODULE INPUTS
	
		//CONTROL SIGNALS
		input	CLOCK,
		input 	RESET,

		//ID
		input Jump_IN,
		input Branch_IN,
		input  [4:0] IDRegRS_IN,
		input  [4:0] IDRegRT_IN,

		//ID/EXE
		input [4:0] IDEXEWriteReg_IN,
		input IDEXEWriteEnable_IN,

		//EXE/MEM
		input [4:0] EXEMEMWriteReg_IN,
		input EXEMEMMemRead_IN,	

	//MODULE OUTPUTS

		output 	STALL_IFID,
		output 	FLUSH_IFID,
	
		output 	STALL_IDEXE,
		output 	FLUSH_IDEXE,
	
		output 	STALL_EXEMEM,
		output 	FLUSH_EXEMEM,
	
		output 	STALL_MEMWB,
		output 	FLUSH_MEMWB

);

reg [4:0] MultiCycleRing;

assign FLUSH_MEMWB = 1'b0;
assign STALL_MEMWB = 1'b0;

assign FLUSH_EXEMEM = 1'b0;
assign STALL_EXEMEM = (FLUSH_MEMWB || STALL_MEMWB);

assign FLUSH_IDEXE = 1'b0;
assign STALL_IDEXE = (FLUSH_EXEMEM || STALL_EXEMEM);

assign FLUSH_IFID = !(MultiCycleRing[0]);
assign STALL_IFID = (FLUSH_IDEXE || STALL_IDEXE || FLUSH_IFID);

always @(posedge CLOCK or negedge RESET) begin

	if(!RESET) begin

		MultiCycleRing <= 5'b00001;

	end else if(CLOCK) begin

		$display("");
		$display("----- HAZARD UNIT -----");
		$display("Multicycle Ring: %b", MultiCycleRing);

		MultiCycleRing <= {{MultiCycleRing[3:0],MultiCycleRing[4]}};

		if(((IDEXEWriteEnable_IN)&& ((Branch_IN || Jumb_IN)&&((IDRegisterRS_IN == IDEXEWriteRegister_IN)||(IDRegisterRT_IN == IDEXEWriteRegister_IN))))||((Branch_IN || Jumb_IN)&&EXEMEMMemRead_IN &&((EXEMEMWriteRegister_IN ==IDRegisterRS_IN) || (EXEMEMWriteRegister_IN ==IDRegisterRT_IN))))begin
			assign FLUSH_IDEXE_Enable= 1'b1;
		end else
			assign FLUSH_IDEXE_Enable= 1'b0;
		end

end

endmodule


