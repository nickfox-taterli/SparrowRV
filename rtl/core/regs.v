 /*                                                                      
 Copyright 2019 Blue Liang, liangkangnan@163.com
																		 
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
																		 
	 http://www.apache.org/licenses/LICENSE-2.0                          
																		 
 Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */

`include "defines.v"

// 通用寄存器模块
module regs(

	input wire clk,
	input wire rst_n,

	// core 
	//r
	input wire[`RegAddrBus] raddr1_i,     // 读寄存器1地址
	input wire[`RegAddrBus] raddr2_i,     // 读寄存器2地址
	output reg[`RegBus] rdata1_o,         // 读寄存器1数据
	output reg[`RegBus] rdata2_o,         // 读寄存器2数据
	//w
	input wire we_i,                      // 写寄存器标志
	input wire[`RegAddrBus] waddr_i,      // 写寄存器地址
	input wire[`RegBus] wdata_i,          // 写寄存器数据

	// bus 
	input wire[`RegAddrBus] bus_raddr_i,  // 读寄存器地址
	output reg[`RegBus] bus_data_o       // 读寄存器数据

	);

	reg[`RegBus] regs[0:`RegNum - 1];

	// 写寄存器
	always @ (posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			regs[1] <= 32'h0;
			regs[2] <= 32'h0;
			regs[3] <= 32'h0;
			regs[4] <= 32'h0;
			regs[5] <= 32'h0;
			regs[6] <= 32'h0;
			regs[7] <= 32'h0;
			regs[8] <= 32'h0;
			regs[9] <= 32'h0;
			regs[10] <= 32'h0;
			regs[11] <= 32'h0;
			regs[12] <= 32'h0;
			regs[13] <= 32'h0;
			regs[14] <= 32'h0;
			regs[15] <= 32'h0;
			regs[16] <= 32'h0;
			regs[17] <= 32'h0;
			regs[18] <= 32'h0;
			regs[19] <= 32'h0;
			regs[20] <= 32'h0;
			regs[21] <= 32'h0;
			regs[22] <= 32'h0;
			regs[23] <= 32'h0;
			regs[24] <= 32'h0;
			regs[25] <= 32'h0;
			regs[26] <= 32'h0;
			regs[27] <= 32'h0;
			regs[28] <= 32'h0;
			regs[29] <= 32'h0;
			regs[30] <= 32'h0;
			regs[31] <= 32'h0;
		end
		else begin
			if ((we_i == `WriteEnable) && (waddr_i != `ZeroReg)) begin
				regs[waddr_i] <= wdata_i;
			end
		end
	end

	// 读寄存器1
	always @ (*) begin
		if (raddr1_i == `ZeroReg) begin
			rdata1_o = `ZeroWord;
		// 如果读地址等于写地址，并且正在写操作，则直接返回写数据
		end else begin
			rdata1_o = regs[raddr1_i];
		end
	end

	// 读寄存器2
	always @ (*) begin
		if (raddr2_i == `ZeroReg) begin
			rdata2_o = `ZeroWord;
		// 如果读地址等于写地址，并且正在写操作，则直接返回写数据
		end else begin
			rdata2_o = regs[raddr2_i];
		end
	end

	// jtag读寄存器
	always @ (*) begin
		if (bus_raddr_i == `ZeroReg) begin
			bus_data_o = `ZeroWord;
		end else begin
			bus_data_o = regs[bus_raddr_i];
		end
	end

endmodule