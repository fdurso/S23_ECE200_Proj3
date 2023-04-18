module Forward(

	//MODULE INPUTS
		input [4:0] IDEX.RegisterRt,
		input [4:0] IDEX.RegisterRs,
		input [4:0] MEMWB.RegisterRd,
		input [4:0] EXMEM.RegisterRd,
		input EXMEM.RegWrite,
		input MEMWB.RegWrite,

	//MODULE OUTPUTS
		output [1:0] ForwardA,
		output [1:0] ForwardB
		
assign ForwardA[0] = (EXMEM.RegWrite & !(EXMEM.RegisterRd == 0) & (EXMEM.RegisterRd = IDEX.RegisterRs))
assign ForwardA[1] = (MEMWB.RegWrite & !(MEMWB.RegisterRd == 0) & (MEMWB.RegisterRd = IDEX.RegisterRs))


assign ForwardB = (EXMEM.RegWrite & !(EXMEM.RegisterRd == 0) & (EXMEM.RegisterRd = IDEX.RegisterRt)) || (MEMWB.RegWrite & !(MEMWB.RegisterRd == 0) & (MEMWB.RegisterRd = IDEX.RegisterRt)) 


);

endmodule
