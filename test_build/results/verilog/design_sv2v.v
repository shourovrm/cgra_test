module RegisterFile__b9e413d457c37299 (
	clk,
	raddr,
	rdata,
	reset,
	waddr,
	wdata,
	wen
);
	input wire [0:0] clk;
	input wire [5:0] raddr;
	output reg [67:0] rdata;
	input wire [0:0] reset;
	input wire [11:0] waddr;
	input wire [135:0] wdata;
	input wire [3:0] wen;
	localparam [31:0] __const__rd_ports_at_up_rf_read = 32'd2;
	localparam [31:0] __const__wr_ports_at_up_rf_write = 32'd4;
	reg [33:0] regs [0:7];
	always @(*) begin : up_rf_read
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__rd_ports_at_up_rf_read; i = i + 1)
				rdata[(1 - i) * 34+:34] = regs[raddr[(1 - i) * 3+:3]];
		end
	end
	always @(posedge clk) begin : up_rf_write
		begin : sv2v_autoblock_2
			reg signed [31:0] i;
			for (i = 0; i < __const__wr_ports_at_up_rf_write; i = i + 1)
				if (wen[3 - i+:1])
					regs[waddr[(3 - i) * 3+:3]] <= wdata[(3 - i) * 34+:34];
		end
	end
endmodule
module DataMemRTL__8bb42015d7ad3eea (
	clk,
	reset,
	recv_raddr__en,
	recv_raddr__msg,
	recv_raddr__rdy,
	recv_waddr__en,
	recv_waddr__msg,
	recv_waddr__rdy,
	recv_wdata__en,
	recv_wdata__msg,
	recv_wdata__rdy,
	send_rdata__en,
	send_rdata__msg,
	send_rdata__rdy
);
	input wire [0:0] clk;
	input wire [0:0] reset;
	input wire [1:0] recv_raddr__en;
	input wire [5:0] recv_raddr__msg;
	output reg [1:0] recv_raddr__rdy;
	input wire [1:0] recv_waddr__en;
	input wire [5:0] recv_waddr__msg;
	output reg [1:0] recv_waddr__rdy;
	input wire [1:0] recv_wdata__en;
	input wire [67:0] recv_wdata__msg;
	output reg [1:0] recv_wdata__rdy;
	output reg [1:0] send_rdata__en;
	output reg [67:0] send_rdata__msg;
	input wire [1:0] send_rdata__rdy;
	localparam [31:0] __const__rd_ports_at_update_read_without_init = 32'd2;
	localparam [31:0] __const__wr_ports_at_update_read_without_init = 32'd2;
	localparam [31:0] __const__rd_ports_at_update_init = 32'd2;
	localparam [31:0] __const__wr_ports_at_update_init = 32'd2;
	localparam [31:0] __const__rd_ports_at_update_signal = 32'd2;
	localparam [31:0] __const__wr_ports_at_update_signal = 32'd2;
	reg [0:0] initWrites [0:7];
	wire [0:0] reg_file__clk;
	reg [5:0] reg_file__raddr;
	wire [67:0] reg_file__rdata;
	wire [0:0] reg_file__reset;
	reg [11:0] reg_file__waddr;
	reg [135:0] reg_file__wdata;
	reg [3:0] reg_file__wen;
	RegisterFile__b9e413d457c37299 reg_file(
		.clk(reg_file__clk),
		.raddr(reg_file__raddr),
		.rdata(reg_file__rdata),
		.reset(reg_file__reset),
		.waddr(reg_file__waddr),
		.wdata(reg_file__wdata),
		.wen(reg_file__wen)
	);
	always @(*) begin : update_read_without_init
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__rd_ports_at_update_read_without_init; i = i + 1)
				begin
					reg_file__wen[3 - (__const__wr_ports_at_update_read_without_init + i)+:1] = 1'd0;
					reg_file__raddr[(1 - i) * 3+:3] = recv_raddr__msg[(1 - i) * 3+:3];
					send_rdata__msg[(1 - i) * 34+:34] = reg_file__rdata[(1 - i) * 34+:34];
				end
		end
		begin : sv2v_autoblock_2
			reg signed [31:0] i;
			for (i = 0; i < __const__wr_ports_at_update_read_without_init; i = i + 1)
				if (recv_waddr__en[1 - i+:1] == 1'd1) begin
					reg_file__waddr[(3 - i) * 3+:3] = recv_waddr__msg[(1 - i) * 3+:3];
					reg_file__wdata[(3 - i) * 34+:34] = recv_wdata__msg[(1 - i) * 34+:34];
					reg_file__wen[3 - i+:1] = recv_wdata__en[1 - i+:1] && recv_waddr__en[1 - i+:1];
				end
		end
	end
	always @(*) begin : update_signal
		begin : sv2v_autoblock_3
			reg signed [31:0] i;
			for (i = 0; i < __const__rd_ports_at_update_signal; i = i + 1)
				begin
					recv_raddr__rdy[1 - i+:1] = send_rdata__rdy[1 - i+:1];
					send_rdata__en[1 - i+:1] = recv_raddr__en[1 - i+:1];
				end
		end
		begin : sv2v_autoblock_4
			reg signed [31:0] i;
			for (i = 0; i < __const__wr_ports_at_update_signal; i = i + 1)
				begin
					recv_waddr__rdy[1 - i+:1] = 1'd1;
					recv_wdata__rdy[1 - i+:1] = 1'd1;
				end
		end
	end
	always @(posedge clk) begin : update_init
		begin : sv2v_autoblock_5
			reg signed [31:0] i;
			for (i = 0; i < __const__rd_ports_at_update_init; i = i + 1)
				if (recv_raddr__en[1 - i+:1] == 1'd1)
					initWrites[recv_raddr__msg[(1 - i) * 3+:3]] <= initWrites[recv_raddr__msg[(1 - i) * 3+:3]] | 1'd1;
		end
		begin : sv2v_autoblock_6
			reg signed [31:0] i;
			for (i = 0; i < __const__wr_ports_at_update_init; i = i + 1)
				if (recv_waddr__en[1 - i+:1] == 1'd1)
					initWrites[recv_waddr__msg[(1 - i) * 3+:3]] <= initWrites[recv_waddr__msg[(1 - i) * 3+:3]] | 1'd1;
		end
	end
	assign reg_file__clk = clk;
	assign reg_file__reset = reset;
endmodule
module NormalQueueCtrlRTL__num_entries_2 (
	clk,
	count,
	deq_en,
	deq_rdy,
	enq_en,
	enq_rdy,
	raddr,
	reset,
	waddr,
	wen
);
	input wire [0:0] clk;
	output reg [1:0] count;
	input wire [0:0] deq_en;
	output reg [0:0] deq_rdy;
	input wire [0:0] enq_en;
	output reg [0:0] enq_rdy;
	output wire [0:0] raddr;
	input wire [0:0] reset;
	output wire [0:0] waddr;
	output wire [0:0] wen;
	localparam [0:0] last_idx = 1'd1;
	localparam [1:0] num_entries = 2'd2;
	reg [0:0] deq_xfer;
	reg [0:0] enq_xfer;
	reg [0:0] head;
	reg [0:0] tail;
	always @(*) begin : _lambda__s_dut_tile_0__channel_0__queues_0__ctrl_deq_rdy
		deq_rdy = ~reset & (count > 2'd0);
	end
	always @(*) begin : _lambda__s_dut_tile_0__channel_0__queues_0__ctrl_deq_xfer
		deq_xfer = deq_en & deq_rdy;
	end
	always @(*) begin : _lambda__s_dut_tile_0__channel_0__queues_0__ctrl_enq_rdy
		enq_rdy = ~reset & (count < num_entries);
	end
	always @(*) begin : _lambda__s_dut_tile_0__channel_0__queues_0__ctrl_enq_xfer
		enq_xfer = enq_en & enq_rdy;
	end
	always @(posedge clk) begin : up_reg
		if (reset) begin
			head <= 1'd0;
			tail <= 1'd0;
			count <= 2'd0;
		end
		else begin
			if (deq_xfer)
				head <= (head < last_idx ? head + 1'd1 : 1'd0);
			if (enq_xfer)
				tail <= (tail < last_idx ? tail + 1'd1 : 1'd0);
			if (enq_xfer & ~deq_xfer)
				count <= count + 2'd1;
			if (~enq_xfer & deq_xfer)
				count <= count - 2'd1;
		end
	end
	assign wen = enq_xfer;
	assign waddr = tail;
	assign raddr = head;
endmodule
module RegisterFile__e355018d318c7c45 (
	clk,
	raddr,
	rdata,
	reset,
	waddr,
	wdata,
	wen
);
	input wire [0:0] clk;
	input wire [0:0] raddr;
	output reg [33:0] rdata;
	input wire [0:0] reset;
	input wire [0:0] waddr;
	input wire [33:0] wdata;
	input wire [0:0] wen;
	localparam [31:0] __const__rd_ports_at_up_rf_read = 32'd1;
	localparam [31:0] __const__wr_ports_at_up_rf_write = 32'd1;
	reg [33:0] regs [0:1];
	always @(*) begin : up_rf_read
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__rd_ports_at_up_rf_read; i = i + 1)
				rdata[i * 34+:34] = regs[raddr[i+:1]];
		end
	end
	always @(posedge clk) begin : up_rf_write
		begin : sv2v_autoblock_2
			reg signed [31:0] i;
			for (i = 0; i < __const__wr_ports_at_up_rf_write; i = i + 1)
				if (wen[i+:1])
					regs[waddr[i+:1]] <= wdata[i * 34+:34];
		end
	end
endmodule
module NormalQueueDpathRTL__EntryType_CGRAData_32_1_1__num_entries_2 (
	clk,
	deq_ret,
	enq_msg,
	raddr,
	reset,
	waddr,
	wen
);
	input wire [0:0] clk;
	output wire [33:0] deq_ret;
	input wire [33:0] enq_msg;
	input wire [0:0] raddr;
	input wire [0:0] reset;
	input wire [0:0] waddr;
	input wire [0:0] wen;
	wire [0:0] queue__clk;
	wire [0:0] queue__raddr;
	wire [33:0] queue__rdata;
	wire [0:0] queue__reset;
	wire [0:0] queue__waddr;
	wire [33:0] queue__wdata;
	wire [0:0] queue__wen;
	RegisterFile__e355018d318c7c45 queue(
		.clk(queue__clk),
		.raddr(queue__raddr),
		.rdata(queue__rdata),
		.reset(queue__reset),
		.waddr(queue__waddr),
		.wdata(queue__wdata),
		.wen(queue__wen)
	);
	assign queue__clk = clk;
	assign queue__reset = reset;
	assign queue__raddr[0+:1] = raddr;
	assign deq_ret = queue__rdata[0+:34];
	assign queue__wen[0+:1] = wen;
	assign queue__waddr[0+:1] = waddr;
	assign queue__wdata[0+:34] = enq_msg;
endmodule
module NormalQueueRTL__EntryType_CGRAData_32_1_1__num_entries_2 (
	clk,
	count,
	reset,
	deq__en,
	deq__rdy,
	deq__ret,
	enq__en,
	enq__msg,
	enq__rdy
);
	input wire [0:0] clk;
	output wire [1:0] count;
	input wire [0:0] reset;
	input wire [0:0] deq__en;
	output wire [0:0] deq__rdy;
	output wire [33:0] deq__ret;
	input wire [0:0] enq__en;
	input wire [33:0] enq__msg;
	output wire [0:0] enq__rdy;
	wire [0:0] ctrl__clk;
	wire [1:0] ctrl__count;
	wire [0:0] ctrl__deq_en;
	wire [0:0] ctrl__deq_rdy;
	wire [0:0] ctrl__enq_en;
	wire [0:0] ctrl__enq_rdy;
	wire [0:0] ctrl__raddr;
	wire [0:0] ctrl__reset;
	wire [0:0] ctrl__waddr;
	wire [0:0] ctrl__wen;
	NormalQueueCtrlRTL__num_entries_2 ctrl(
		.clk(ctrl__clk),
		.count(ctrl__count),
		.deq_en(ctrl__deq_en),
		.deq_rdy(ctrl__deq_rdy),
		.enq_en(ctrl__enq_en),
		.enq_rdy(ctrl__enq_rdy),
		.raddr(ctrl__raddr),
		.reset(ctrl__reset),
		.waddr(ctrl__waddr),
		.wen(ctrl__wen)
	);
	wire [0:0] dpath__clk;
	wire [33:0] dpath__deq_ret;
	wire [33:0] dpath__enq_msg;
	wire [0:0] dpath__raddr;
	wire [0:0] dpath__reset;
	wire [0:0] dpath__waddr;
	wire [0:0] dpath__wen;
	NormalQueueDpathRTL__EntryType_CGRAData_32_1_1__num_entries_2 dpath(
		.clk(dpath__clk),
		.deq_ret(dpath__deq_ret),
		.enq_msg(dpath__enq_msg),
		.raddr(dpath__raddr),
		.reset(dpath__reset),
		.waddr(dpath__waddr),
		.wen(dpath__wen)
	);
	assign ctrl__clk = clk;
	assign ctrl__reset = reset;
	assign dpath__clk = clk;
	assign dpath__reset = reset;
	assign dpath__wen = ctrl__wen;
	assign dpath__waddr = ctrl__waddr;
	assign dpath__raddr = ctrl__raddr;
	assign ctrl__enq_en = enq__en;
	assign enq__rdy = ctrl__enq_rdy;
	assign ctrl__deq_en = deq__en;
	assign deq__rdy = ctrl__deq_rdy;
	assign count = ctrl__count;
	assign dpath__enq_msg = enq__msg;
	assign deq__ret = dpath__deq_ret;
endmodule
module ChannelRTL__DataType_CGRAData_32_1_1__latency_1 (
	clk,
	count,
	reset,
	recv__en,
	recv__msg,
	recv__rdy,
	send__en,
	send__msg,
	send__rdy
);
	input wire [0:0] clk;
	output wire [1:0] count;
	input wire [0:0] reset;
	input wire [0:0] recv__en;
	input wire [33:0] recv__msg;
	output reg [0:0] recv__rdy;
	output reg [0:0] send__en;
	output reg [33:0] send__msg;
	input wire [0:0] send__rdy;
	localparam [33:0] data = 34'h000000000;
	localparam [31:0] latency = 32'd1;
	wire [0:0] queues__clk [0:0];
	wire [1:0] queues__count [0:0];
	wire [0:0] queues__reset [0:0];
	reg [0:0] queues__deq__en [0:0];
	wire [0:0] queues__deq__rdy [0:0];
	wire [33:0] queues__deq__ret [0:0];
	reg [0:0] queues__enq__en [0:0];
	reg [33:0] queues__enq__msg [0:0];
	wire [0:0] queues__enq__rdy [0:0];
	NormalQueueRTL__EntryType_CGRAData_32_1_1__num_entries_2 queues__0(
		.clk(queues__clk[0]),
		.count(queues__count[0]),
		.reset(queues__reset[0]),
		.deq__en(queues__deq__en[0]),
		.deq__rdy(queues__deq__rdy[0]),
		.deq__ret(queues__deq__ret[0]),
		.enq__en(queues__enq__en[0]),
		.enq__msg(queues__enq__msg[0]),
		.enq__rdy(queues__enq__rdy[0])
	);
	always @(*) begin : process
		if (recv__msg[0] == 1'd0) begin
			recv__rdy = queues__enq__rdy[0];
			queues__enq__msg[0] = recv__msg;
			queues__enq__en[0] = recv__en && queues__enq__rdy[0];
			begin : sv2v_autoblock_1
				reg signed [31:0] i;
				for (i = 0; i < 0; i = i + 1)
					begin
						queues__enq__msg[i + 1] = queues__deq__ret[i];
						queues__enq__en[i + 1] = queues__deq__rdy[i] && queues__enq__rdy[i + 1];
						queues__deq__en[i] = queues__enq__en[i + 1];
					end
			end
			send__msg = queues__deq__ret[0];
			send__en = send__rdy && queues__deq__rdy[0];
			queues__deq__en[0] = send__en;
		end
		else begin
			send__msg = data;
			send__msg[33-:32] = recv__msg[33-:32];
			send__msg[1] = recv__msg[1];
			send__msg[0] = 1'd0;
			send__en = send__rdy && recv__en;
			recv__rdy = send__rdy;
		end
	end
	assign queues__clk[0] = clk;
	assign queues__reset[0] = reset;
	assign count = queues__count[0];
endmodule
module ConstQueueRTL__2f4560623c67a554 (
	clk,
	reset,
	send_const__en,
	send_const__msg,
	send_const__rdy
);
	input wire [0:0] clk;
	input wire [0:0] reset;
	output reg [0:0] send_const__en;
	output reg [33:0] send_const__msg;
	input wire [0:0] send_const__rdy;
	localparam [33:0] const_queue = 34'h000000000;
	localparam [31:0] __const__num_const_at_update_raddr = 32'd1;
	reg [0:0] cur;
	always @(*) begin : load
		send_const__msg = const_queue[cur * 34+:34];
	end
	always @(*) begin : update_en
		send_const__en = send_const__rdy;
	end
	always @(posedge clk) begin : update_raddr
		if (send_const__rdy)
			if ((cur + 1'd1) >= 1'd1)
				cur <= 1'd0;
			else
				cur <= cur + 1'd1;
	end
endmodule
module CrossbarRTL__874305e17dbe6b02 (
	clk,
	reset,
	recv_data__en,
	recv_data__msg,
	recv_data__rdy,
	recv_opt__en,
	recv_opt__msg,
	recv_opt__rdy,
	send_data__en,
	send_data__msg,
	send_data__rdy,
	send_predicate__en,
	send_predicate__msg,
	send_predicate__rdy
);
	input wire [0:0] clk;
	input wire [0:0] reset;
	input wire [9:0] recv_data__en;
	input wire [339:0] recv_data__msg;
	output reg [9:0] recv_data__rdy;
	input wire [0:0] recv_opt__en;
	input wire [58:0] recv_opt__msg;
	output reg [0:0] recv_opt__rdy;
	output reg [11:0] send_data__en;
	output reg [407:0] send_data__msg;
	input wire [11:0] send_data__rdy;
	output reg [0:0] send_predicate__en;
	output reg [1:0] send_predicate__msg;
	input wire [0:0] send_predicate__rdy;
	localparam [31:0] bypass_point = 32'd4;
	localparam [5:0] __const__OPT_START = 6'd0;
	localparam [31:0] __const__num_inports_at_update_signal = 32'd10;
	localparam [31:0] __const__num_outports_at_update_signal = 32'd12;
	reg [0:0] __tmpvar__update_signal_out_rdy;
	reg [3:0] __tmpvar__update_signal_in_dir;
	function automatic [3:0] sv2v_cast_4;
		input reg [3:0] inp;
		sv2v_cast_4 = inp;
	endfunction
	always @(*) begin : update_signal
		__tmpvar__update_signal_out_rdy = 1'd0;
		send_predicate__en = 1'd0;
		if (recv_opt__msg[52] == 1'd1)
			send_predicate__msg = 2'h0;
		if (recv_opt__msg[58-:6] != __const__OPT_START) begin
			begin : sv2v_autoblock_1
				reg signed [31:0] i;
				for (i = 0; i < __const__num_inports_at_update_signal; i = i + 1)
					if ((recv_opt__msg[0 + i+:1] == 1'd1) && (recv_data__en[9 - i+:1] == 1'd1)) begin
						send_predicate__en = 1'd1;
						send_predicate__msg[1] = 1'd1;
						send_predicate__msg[0] = send_predicate__msg[0] | recv_data__msg[((9 - i) * 34) + 1];
					end
			end
			begin : sv2v_autoblock_2
				reg signed [31:0] i;
				for (i = 0; i < __const__num_outports_at_update_signal; i = i + 1)
					begin
						__tmpvar__update_signal_in_dir = recv_opt__msg[8 + (i * 4)+:4];
						__tmpvar__update_signal_out_rdy = __tmpvar__update_signal_out_rdy | send_data__rdy[11 - i+:1];
						if ((__tmpvar__update_signal_in_dir > 4'd0) && send_data__rdy[11 - i+:1]) begin
							__tmpvar__update_signal_in_dir = __tmpvar__update_signal_in_dir - 4'd1;
							recv_data__rdy[9 - __tmpvar__update_signal_in_dir+:1] = send_data__rdy[11 - i+:1];
							send_data__en[11 - i+:1] = recv_data__en[9 - __tmpvar__update_signal_in_dir+:1];
							if (send_data__en[11 - i+:1] && recv_data__rdy[9 - __tmpvar__update_signal_in_dir+:1]) begin
								send_data__msg[((11 - i) * 34) + 33-:32] = recv_data__msg[((9 - __tmpvar__update_signal_in_dir) * 34) + 33-:32];
								send_data__msg[((11 - i) * 34) + 1] = recv_data__msg[((9 - __tmpvar__update_signal_in_dir) * 34) + 1];
								send_data__msg[(11 - i) * 34] = recv_data__msg[(9 - __tmpvar__update_signal_in_dir) * 34];
							end
							if ((__tmpvar__update_signal_in_dir >= sv2v_cast_4(bypass_point)) && (i < bypass_point))
								send_data__msg[(11 - i) * 34] = 1'd1;
							else
								send_data__msg[(11 - i) * 34] = 1'd0;
						end
						else
							send_data__en[11 - i+:1] = 1'd0;
					end
			end
		end
		else begin : sv2v_autoblock_3
			reg signed [31:0] i;
			for (i = 0; i < __const__num_outports_at_update_signal; i = i + 1)
				send_data__en[11 - i+:1] = 1'd0;
		end
		recv_opt__rdy = __tmpvar__update_signal_out_rdy;
	end
endmodule
module RegisterFile__ff3fced67c114009 (
	clk,
	raddr,
	rdata,
	reset,
	waddr,
	wdata,
	wen
);
	input wire [0:0] clk;
	input wire [2:0] raddr;
	output reg [58:0] rdata;
	input wire [0:0] reset;
	input wire [2:0] waddr;
	input wire [58:0] wdata;
	input wire [0:0] wen;
	localparam [31:0] __const__rd_ports_at_up_rf_read = 32'd1;
	localparam [31:0] __const__wr_ports_at_up_rf_write = 32'd1;
	reg [58:0] regs [0:7];
	always @(*) begin : up_rf_read
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__rd_ports_at_up_rf_read; i = i + 1)
				rdata[i * 59+:59] = regs[raddr[i * 3+:3]];
		end
	end
	always @(posedge clk) begin : up_rf_write
		begin : sv2v_autoblock_2
			reg signed [31:0] i;
			for (i = 0; i < __const__wr_ports_at_up_rf_write; i = i + 1)
				if (wen[i+:1])
					regs[waddr[i * 3+:3]] <= wdata[i * 59+:59];
		end
	end
endmodule
module CtrlMemRTL__ebe00becbc7c6d54 (
	clk,
	reset,
	recv_ctrl__en,
	recv_ctrl__msg,
	recv_ctrl__rdy,
	recv_waddr__en,
	recv_waddr__msg,
	recv_waddr__rdy,
	send_ctrl__en,
	send_ctrl__msg,
	send_ctrl__rdy
);
	input wire [0:0] clk;
	input wire [0:0] reset;
	input wire [0:0] recv_ctrl__en;
	input wire [58:0] recv_ctrl__msg;
	output reg [0:0] recv_ctrl__rdy;
	input wire [0:0] recv_waddr__en;
	input wire [2:0] recv_waddr__msg;
	output reg [0:0] recv_waddr__rdy;
	output reg [0:0] send_ctrl__en;
	output wire [58:0] send_ctrl__msg;
	input wire [0:0] send_ctrl__rdy;
	localparam [31:0] __const__num_ctrl_at_update_signal = 32'd4;
	localparam [5:0] __const__OPT_START = 6'd0;
	localparam [31:0] __const__num_ctrl_at_update_raddr = 32'd4;
	localparam [2:0] __const__last_item_at_update_raddr = 3'd7;
	reg [2:0] times;
	wire [0:0] reg_file__clk;
	reg [2:0] reg_file__raddr;
	wire [58:0] reg_file__rdata;
	wire [0:0] reg_file__reset;
	wire [2:0] reg_file__waddr;
	wire [58:0] reg_file__wdata;
	wire [0:0] reg_file__wen;
	RegisterFile__ff3fced67c114009 reg_file(
		.clk(reg_file__clk),
		.raddr(reg_file__raddr),
		.rdata(reg_file__rdata),
		.reset(reg_file__reset),
		.waddr(reg_file__waddr),
		.wdata(reg_file__wdata),
		.wen(reg_file__wen)
	);
	always @(*) begin : update_signal
		if ((times == 3'd4) || (reg_file__rdata[58-:6] == __const__OPT_START))
			send_ctrl__en = 1'd0;
		else
			send_ctrl__en = send_ctrl__rdy;
		recv_waddr__rdy = 1'd1;
		recv_ctrl__rdy = 1'd1;
	end
	always @(posedge clk) begin : update_raddr
		if (reg_file__rdata[58-:6] != __const__OPT_START) begin
			if (times < 3'd4)
				times <= times + 3'd1;
			if (reg_file__raddr[0+:3] < __const__last_item_at_update_raddr)
				reg_file__raddr[0+:3] <= reg_file__raddr[0+:3] + 3'd1;
			else
				reg_file__raddr[0+:3] <= 3'd0;
		end
	end
	assign reg_file__clk = clk;
	assign reg_file__reset = reset;
	assign send_ctrl__msg = reg_file__rdata[0+:59];
	assign reg_file__waddr[0+:3] = recv_waddr__msg;
	assign reg_file__wdata[0+:59] = recv_ctrl__msg;
	assign reg_file__wen[0+:1] = recv_waddr__en;
endmodule
module PhiRTL__a050676efb0a4b04 (
	clk,
	initial_carry_in,
	initial_carry_out,
	recv_in_count,
	reset,
	from_mem_rdata__en,
	from_mem_rdata__msg,
	from_mem_rdata__rdy,
	recv_const__en,
	recv_const__msg,
	recv_const__rdy,
	recv_in__en,
	recv_in__msg,
	recv_in__rdy,
	recv_opt__en,
	recv_opt__msg,
	recv_opt__rdy,
	recv_predicate__en,
	recv_predicate__msg,
	recv_predicate__rdy,
	send_out__en,
	send_out__msg,
	send_out__rdy,
	to_mem_raddr__en,
	to_mem_raddr__msg,
	to_mem_raddr__rdy,
	to_mem_waddr__en,
	to_mem_waddr__msg,
	to_mem_waddr__rdy,
	to_mem_wdata__en,
	to_mem_wdata__msg,
	to_mem_wdata__rdy
);
	input wire [0:0] clk;
	input wire [0:0] initial_carry_in;
	output wire [0:0] initial_carry_out;
	input wire [7:0] recv_in_count;
	input wire [0:0] reset;
	input wire [0:0] from_mem_rdata__en;
	input wire [33:0] from_mem_rdata__msg;
	output reg [0:0] from_mem_rdata__rdy;
	input wire [0:0] recv_const__en;
	input wire [33:0] recv_const__msg;
	output reg [0:0] recv_const__rdy;
	input wire [3:0] recv_in__en;
	input wire [135:0] recv_in__msg;
	output reg [3:0] recv_in__rdy;
	input wire [0:0] recv_opt__en;
	input wire [58:0] recv_opt__msg;
	output reg [0:0] recv_opt__rdy;
	input wire [0:0] recv_predicate__en;
	input wire [1:0] recv_predicate__msg;
	output reg [0:0] recv_predicate__rdy;
	output reg [1:0] send_out__en;
	output reg [67:0] send_out__msg;
	input wire [1:0] send_out__rdy;
	output reg [0:0] to_mem_raddr__en;
	output reg [2:0] to_mem_raddr__msg;
	input wire [0:0] to_mem_raddr__rdy;
	output reg [0:0] to_mem_waddr__en;
	output reg [2:0] to_mem_waddr__msg;
	input wire [0:0] to_mem_waddr__rdy;
	output reg [0:0] to_mem_wdata__en;
	output reg [33:0] to_mem_wdata__msg;
	input wire [0:0] to_mem_wdata__rdy;
	localparam [33:0] const_zero = 34'h000000000;
	localparam [31:0] __const__num_outports_at_update_signal = 32'd2;
	localparam [31:0] __const__num_inports_at_comb_logic = 32'd4;
	localparam [31:0] __const__num_outports_at_comb_logic = 32'd2;
	localparam [5:0] __const__OPT_PHI = 6'd17;
	localparam [5:0] __const__OPT_PHI_CONST = 6'd32;
	reg [2:0] __tmpvar__comb_logic_in0;
	reg [2:0] __tmpvar__comb_logic_in1;
	always @(*) begin : comb_logic
		__tmpvar__comb_logic_in0 = 3'd0;
		__tmpvar__comb_logic_in1 = 3'd0;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__num_inports_at_comb_logic; i = i + 1)
				recv_in__rdy[3 - i+:1] = 1'd0;
		end
		recv_predicate__rdy = 1'd0;
		if (recv_opt__en) begin
			if (recv_opt__msg[40+:3] != 3'd0) begin
				__tmpvar__comb_logic_in0 = recv_opt__msg[40+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd1;
			end
			if (recv_opt__msg[43+:3] != 3'd0) begin
				__tmpvar__comb_logic_in1 = recv_opt__msg[43+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd1;
			end
			if (recv_opt__msg[52] == 1'd1)
				recv_predicate__rdy = 1'd1;
		end
		begin : sv2v_autoblock_2
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				send_out__en[1 - j+:1] = recv_opt__en;
		end
		if (recv_opt__msg[58-:6] == __const__OPT_PHI) begin
			if (recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1] == 1'd1) begin
				send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32];
				send_out__msg[35] = 1'd1;
			end
			else if (recv_in__msg[((3 - __tmpvar__comb_logic_in1) * 34) + 1] == 1'd1) begin
				send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in1) * 34) + 33-:32];
				send_out__msg[35] = 1'd1;
			end
			else begin
				send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32];
				send_out__msg[35] = 1'd0;
			end
			if (recv_opt__en && ((recv_in_count[(3 - __tmpvar__comb_logic_in0) * 2+:2] == 2'd0) || (recv_in_count[(3 - __tmpvar__comb_logic_in1) * 2+:2] == 2'd0))) begin
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd0;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd0;
				recv_predicate__rdy = 1'd0;
				send_out__msg[35] = 1'd0;
			end
			if ((recv_opt__msg[52] == 1'd1) && (recv_predicate__msg[1] == 1'd0)) begin
				recv_predicate__rdy = 1'd0;
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd0;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd0;
			end
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_PHI_CONST) begin
			send_out__msg[35] = 1'd1;
			if (recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1] == 1'd1)
				send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32];
			else
				send_out__msg[67-:32] = recv_const__msg[33-:32];
			if ((recv_opt__msg[52] == 1'd1) && (recv_predicate__msg[1] == 1'd0))
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd0;
		end
		else begin : sv2v_autoblock_3
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				send_out__en[1 - j+:1] = 1'd0;
		end
		if (recv_opt__msg[52] == 1'd1) begin
			send_out__msg[35] = send_out__msg[35] && recv_predicate__msg[0];
			if (recv_opt__msg[58-:6] == __const__OPT_PHI_CONST)
				if (recv_predicate__msg[1] == 1'd0)
					send_out__msg[35] = 1'd1;
		end
	end
	always @(*) begin : update_mem
		to_mem_waddr__en = 1'd0;
		to_mem_wdata__en = 1'd0;
		to_mem_wdata__msg = const_zero;
		to_mem_waddr__msg = 3'd0;
		to_mem_raddr__msg = 3'd0;
		to_mem_raddr__en = 1'd0;
		from_mem_rdata__rdy = 1'd0;
	end
	always @(*) begin : update_signal
		begin : sv2v_autoblock_4
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_update_signal; j = j + 1)
				begin
					recv_const__rdy = send_out__rdy[1 - j+:1] || recv_const__rdy;
					recv_opt__rdy = send_out__rdy[1 - j+:1] || recv_opt__rdy;
				end
		end
	end
endmodule
module AdderRTL__a050676efb0a4b04 (
	clk,
	initial_carry_in,
	initial_carry_out,
	recv_in_count,
	reset,
	from_mem_rdata__en,
	from_mem_rdata__msg,
	from_mem_rdata__rdy,
	recv_const__en,
	recv_const__msg,
	recv_const__rdy,
	recv_in__en,
	recv_in__msg,
	recv_in__rdy,
	recv_opt__en,
	recv_opt__msg,
	recv_opt__rdy,
	recv_predicate__en,
	recv_predicate__msg,
	recv_predicate__rdy,
	send_out__en,
	send_out__msg,
	send_out__rdy,
	to_mem_raddr__en,
	to_mem_raddr__msg,
	to_mem_raddr__rdy,
	to_mem_waddr__en,
	to_mem_waddr__msg,
	to_mem_waddr__rdy,
	to_mem_wdata__en,
	to_mem_wdata__msg,
	to_mem_wdata__rdy
);
	input wire [0:0] clk;
	input wire [0:0] initial_carry_in;
	output wire [0:0] initial_carry_out;
	input wire [7:0] recv_in_count;
	input wire [0:0] reset;
	input wire [0:0] from_mem_rdata__en;
	input wire [33:0] from_mem_rdata__msg;
	output reg [0:0] from_mem_rdata__rdy;
	input wire [0:0] recv_const__en;
	input wire [33:0] recv_const__msg;
	output reg [0:0] recv_const__rdy;
	input wire [3:0] recv_in__en;
	input wire [135:0] recv_in__msg;
	output reg [3:0] recv_in__rdy;
	input wire [0:0] recv_opt__en;
	input wire [58:0] recv_opt__msg;
	output reg [0:0] recv_opt__rdy;
	input wire [0:0] recv_predicate__en;
	input wire [1:0] recv_predicate__msg;
	output reg [0:0] recv_predicate__rdy;
	output reg [1:0] send_out__en;
	output reg [67:0] send_out__msg;
	input wire [1:0] send_out__rdy;
	output reg [0:0] to_mem_raddr__en;
	output reg [2:0] to_mem_raddr__msg;
	input wire [0:0] to_mem_raddr__rdy;
	output reg [0:0] to_mem_waddr__en;
	output reg [2:0] to_mem_waddr__msg;
	input wire [0:0] to_mem_waddr__rdy;
	output reg [0:0] to_mem_wdata__en;
	output reg [33:0] to_mem_wdata__msg;
	input wire [0:0] to_mem_wdata__rdy;
	localparam [33:0] const_one = 34'h000000006;
	localparam [33:0] const_zero = 34'h000000000;
	localparam [31:0] __const__num_outports_at_update_signal = 32'd2;
	localparam [31:0] __const__num_inports_at_comb_logic = 32'd4;
	localparam [31:0] __const__num_outports_at_comb_logic = 32'd2;
	localparam [5:0] __const__OPT_ADD = 6'd2;
	localparam [5:0] __const__OPT_ADD_CONST = 6'd25;
	localparam [5:0] __const__OPT_INC = 6'd3;
	localparam [5:0] __const__OPT_SUB = 6'd4;
	localparam [5:0] __const__OPT_PAS = 6'd31;
	reg [2:0] __tmpvar__comb_logic_in0;
	reg [2:0] __tmpvar__comb_logic_in1;
	always @(*) begin : comb_logic
		__tmpvar__comb_logic_in0 = 3'd0;
		__tmpvar__comb_logic_in1 = 3'd0;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__num_inports_at_comb_logic; i = i + 1)
				recv_in__rdy[3 - i+:1] = 1'd0;
		end
		recv_predicate__rdy = 1'd0;
		if (recv_opt__en) begin
			if (recv_opt__msg[40+:3] != 3'd0) begin
				__tmpvar__comb_logic_in0 = recv_opt__msg[40+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd1;
			end
			if (recv_opt__msg[43+:3] != 3'd0) begin
				__tmpvar__comb_logic_in1 = recv_opt__msg[43+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd1;
			end
			if (recv_opt__msg[52] == 1'd1)
				recv_predicate__rdy = 1'd1;
		end
		send_out__msg[35] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1] && recv_in__msg[((3 - __tmpvar__comb_logic_in1) * 34) + 1];
		begin : sv2v_autoblock_2
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				send_out__en[1 - j+:1] = recv_opt__en;
		end
		if (recv_opt__msg[58-:6] == __const__OPT_ADD) begin
			send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32] + recv_in__msg[((3 - __tmpvar__comb_logic_in1) * 34) + 33-:32];
			send_out__msg[35] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1] && recv_in__msg[((3 - __tmpvar__comb_logic_in1) * 34) + 1];
			if (recv_opt__en && ((recv_in_count[(3 - __tmpvar__comb_logic_in0) * 2+:2] == 2'd0) || (recv_in_count[(3 - __tmpvar__comb_logic_in1) * 2+:2] == 2'd0))) begin
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd0;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd0;
				send_out__msg[35] = 1'd0;
			end
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_ADD_CONST) begin
			send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32] + recv_const__msg[33-:32];
			send_out__msg[35] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1];
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_INC) begin
			send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32] + const_one[33-:32];
			send_out__msg[35] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1];
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_SUB) begin
			send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32] - recv_in__msg[((3 - __tmpvar__comb_logic_in1) * 34) + 33-:32];
			send_out__msg[35] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1];
			if (recv_opt__en && ((recv_in_count[(3 - __tmpvar__comb_logic_in0) * 2+:2] == 2'd0) || (recv_in_count[(3 - __tmpvar__comb_logic_in1) * 2+:2] == 2'd0))) begin
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd0;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd0;
				send_out__msg[35] = 1'd0;
			end
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_PAS) begin
			send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32];
			send_out__msg[35] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1];
		end
		else begin : sv2v_autoblock_3
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				send_out__en[1 - j+:1] = 1'd0;
		end
		if (recv_opt__msg[52] == 1'd1)
			send_out__msg[35] = send_out__msg[35] && recv_predicate__msg[0];
	end
	always @(*) begin : update_mem
		to_mem_waddr__en = 1'd0;
		to_mem_wdata__en = 1'd0;
		to_mem_wdata__msg = const_zero;
		to_mem_waddr__msg = 3'd0;
		to_mem_raddr__msg = 3'd0;
		to_mem_raddr__en = 1'd0;
		from_mem_rdata__rdy = 1'd0;
	end
	always @(*) begin : update_signal
		begin : sv2v_autoblock_4
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_update_signal; j = j + 1)
				begin
					recv_const__rdy = send_out__rdy[1 - j+:1] || recv_const__rdy;
					recv_opt__rdy = send_out__rdy[1 - j+:1] || recv_opt__rdy;
				end
		end
	end
endmodule
module CompRTL__a050676efb0a4b04 (
	clk,
	initial_carry_in,
	initial_carry_out,
	recv_in_count,
	reset,
	from_mem_rdata__en,
	from_mem_rdata__msg,
	from_mem_rdata__rdy,
	recv_const__en,
	recv_const__msg,
	recv_const__rdy,
	recv_in__en,
	recv_in__msg,
	recv_in__rdy,
	recv_opt__en,
	recv_opt__msg,
	recv_opt__rdy,
	recv_predicate__en,
	recv_predicate__msg,
	recv_predicate__rdy,
	send_out__en,
	send_out__msg,
	send_out__rdy,
	to_mem_raddr__en,
	to_mem_raddr__msg,
	to_mem_raddr__rdy,
	to_mem_waddr__en,
	to_mem_waddr__msg,
	to_mem_waddr__rdy,
	to_mem_wdata__en,
	to_mem_wdata__msg,
	to_mem_wdata__rdy
);
	input wire [0:0] clk;
	input wire [0:0] initial_carry_in;
	output wire [0:0] initial_carry_out;
	input wire [7:0] recv_in_count;
	input wire [0:0] reset;
	input wire [0:0] from_mem_rdata__en;
	input wire [33:0] from_mem_rdata__msg;
	output reg [0:0] from_mem_rdata__rdy;
	input wire [0:0] recv_const__en;
	input wire [33:0] recv_const__msg;
	output reg [0:0] recv_const__rdy;
	input wire [3:0] recv_in__en;
	input wire [135:0] recv_in__msg;
	output reg [3:0] recv_in__rdy;
	input wire [0:0] recv_opt__en;
	input wire [58:0] recv_opt__msg;
	output reg [0:0] recv_opt__rdy;
	input wire [0:0] recv_predicate__en;
	input wire [1:0] recv_predicate__msg;
	output reg [0:0] recv_predicate__rdy;
	output reg [1:0] send_out__en;
	output reg [67:0] send_out__msg;
	input wire [1:0] send_out__rdy;
	output reg [0:0] to_mem_raddr__en;
	output reg [2:0] to_mem_raddr__msg;
	input wire [0:0] to_mem_raddr__rdy;
	output reg [0:0] to_mem_waddr__en;
	output reg [2:0] to_mem_waddr__msg;
	input wire [0:0] to_mem_waddr__rdy;
	output reg [0:0] to_mem_wdata__en;
	output reg [33:0] to_mem_wdata__msg;
	input wire [0:0] to_mem_wdata__rdy;
	localparam [33:0] const_one = 34'h000000004;
	localparam [33:0] const_zero = 34'h000000000;
	localparam [31:0] __const__num_outports_at_update_signal = 32'd2;
	localparam [31:0] __const__num_inports_at_read_reg = 32'd4;
	localparam [31:0] __const__num_outports_at_read_reg = 32'd2;
	localparam [5:0] __const__OPT_EQ = 6'd14;
	localparam [5:0] __const__OPT_EQ_CONST = 6'd33;
	localparam [5:0] __const__OPT_LE = 6'd15;
	reg [2:0] __tmpvar__read_reg_in0;
	reg [2:0] __tmpvar__read_reg_in1;
	reg [0:0] __tmpvar__read_reg_predicate;
	always @(*) begin : read_reg
		__tmpvar__read_reg_in0 = 3'd0;
		__tmpvar__read_reg_in1 = 3'd0;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__num_inports_at_read_reg; i = i + 1)
				recv_in__rdy[3 - i+:1] = 1'd0;
		end
		recv_predicate__rdy = 1'd0;
		if (recv_opt__en) begin
			if (recv_opt__msg[40+:3] != 3'd0) begin
				__tmpvar__read_reg_in0 = recv_opt__msg[40+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__read_reg_in0+:1] = 1'd1;
			end
			if (recv_opt__msg[43+:3] != 3'd0) begin
				__tmpvar__read_reg_in1 = recv_opt__msg[43+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__read_reg_in1+:1] = 1'd1;
			end
			if (recv_opt__msg[52] == 1'd1)
				recv_predicate__rdy = 1'd1;
		end
		__tmpvar__read_reg_predicate = recv_in__msg[((3 - __tmpvar__read_reg_in0) * 34) + 1] & recv_in__msg[((3 - __tmpvar__read_reg_in1) * 34) + 1];
		send_out__msg[34+:34] = const_one;
		begin : sv2v_autoblock_2
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_read_reg; j = j + 1)
				send_out__en[1 - j+:1] = recv_opt__en;
		end
		if (recv_opt__msg[58-:6] == __const__OPT_EQ) begin
			if (recv_in__msg[((3 - __tmpvar__read_reg_in0) * 34) + 33-:32] == recv_in__msg[((3 - __tmpvar__read_reg_in1) * 34) + 33-:32]) begin
				send_out__msg[34+:34] = const_one;
				send_out__msg[35] = __tmpvar__read_reg_predicate;
			end
			else begin
				send_out__msg[34+:34] = const_zero;
				send_out__msg[35] = __tmpvar__read_reg_predicate;
			end
			if (recv_opt__en && ((recv_in_count[(3 - __tmpvar__read_reg_in0) * 2+:2] == 2'd0) || (recv_in_count[(3 - __tmpvar__read_reg_in1) * 2+:2] == 2'd0))) begin
				recv_in__rdy[3 - __tmpvar__read_reg_in0+:1] = 1'd0;
				recv_in__rdy[3 - __tmpvar__read_reg_in1+:1] = 1'd0;
				send_out__msg[35] = 1'd0;
			end
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_EQ_CONST) begin
			if (recv_in__msg[((3 - __tmpvar__read_reg_in0) * 34) + 33-:32] == recv_const__msg[33-:32]) begin
				send_out__msg[34+:34] = const_one;
				send_out__msg[35] = 1'd1;
			end
			else begin
				send_out__msg[34+:34] = const_zero;
				send_out__msg[35] = 1'd1;
			end
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_LE) begin
			if (recv_in__msg[((3 - __tmpvar__read_reg_in0) * 34) + 33-:32] < recv_in__msg[((3 - __tmpvar__read_reg_in1) * 34) + 33-:32]) begin
				send_out__msg[34+:34] = const_one;
				send_out__msg[35] = __tmpvar__read_reg_predicate;
			end
			else begin
				send_out__msg[34+:34] = const_zero;
				send_out__msg[35] = __tmpvar__read_reg_predicate;
			end
			if (recv_opt__en && ((recv_in_count[(3 - __tmpvar__read_reg_in0) * 2+:2] == 2'd0) || (recv_in_count[(3 - __tmpvar__read_reg_in1) * 2+:2] == 2'd0))) begin
				recv_in__rdy[3 - __tmpvar__read_reg_in0+:1] = 1'd0;
				recv_in__rdy[3 - __tmpvar__read_reg_in1+:1] = 1'd0;
			end
		end
		else begin : sv2v_autoblock_3
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_read_reg; j = j + 1)
				send_out__en[1 - j+:1] = 1'd0;
		end
		if (recv_opt__msg[52] == 1'd1)
			send_out__msg[35] = send_out__msg[35] && recv_predicate__msg[0];
	end
	always @(*) begin : update_mem
		to_mem_waddr__en = 1'd0;
		to_mem_wdata__en = 1'd0;
		to_mem_wdata__msg = const_zero;
		to_mem_waddr__msg = 3'd0;
		to_mem_raddr__msg = 3'd0;
		to_mem_raddr__en = 1'd0;
		from_mem_rdata__rdy = 1'd0;
	end
	always @(*) begin : update_signal
		begin : sv2v_autoblock_4
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_update_signal; j = j + 1)
				begin
					recv_const__rdy = send_out__rdy[1 - j+:1] || recv_const__rdy;
					recv_opt__rdy = send_out__rdy[1 - j+:1] || recv_opt__rdy;
				end
		end
	end
endmodule
module MulRTL__a050676efb0a4b04 (
	clk,
	initial_carry_in,
	initial_carry_out,
	recv_in_count,
	reset,
	from_mem_rdata__en,
	from_mem_rdata__msg,
	from_mem_rdata__rdy,
	recv_const__en,
	recv_const__msg,
	recv_const__rdy,
	recv_in__en,
	recv_in__msg,
	recv_in__rdy,
	recv_opt__en,
	recv_opt__msg,
	recv_opt__rdy,
	recv_predicate__en,
	recv_predicate__msg,
	recv_predicate__rdy,
	send_out__en,
	send_out__msg,
	send_out__rdy,
	to_mem_raddr__en,
	to_mem_raddr__msg,
	to_mem_raddr__rdy,
	to_mem_waddr__en,
	to_mem_waddr__msg,
	to_mem_waddr__rdy,
	to_mem_wdata__en,
	to_mem_wdata__msg,
	to_mem_wdata__rdy
);
	input wire [0:0] clk;
	input wire [0:0] initial_carry_in;
	output wire [0:0] initial_carry_out;
	input wire [7:0] recv_in_count;
	input wire [0:0] reset;
	input wire [0:0] from_mem_rdata__en;
	input wire [33:0] from_mem_rdata__msg;
	output reg [0:0] from_mem_rdata__rdy;
	input wire [0:0] recv_const__en;
	input wire [33:0] recv_const__msg;
	output reg [0:0] recv_const__rdy;
	input wire [3:0] recv_in__en;
	input wire [135:0] recv_in__msg;
	output reg [3:0] recv_in__rdy;
	input wire [0:0] recv_opt__en;
	input wire [58:0] recv_opt__msg;
	output reg [0:0] recv_opt__rdy;
	input wire [0:0] recv_predicate__en;
	input wire [1:0] recv_predicate__msg;
	output reg [0:0] recv_predicate__rdy;
	output reg [1:0] send_out__en;
	output reg [67:0] send_out__msg;
	input wire [1:0] send_out__rdy;
	output reg [0:0] to_mem_raddr__en;
	output reg [2:0] to_mem_raddr__msg;
	input wire [0:0] to_mem_raddr__rdy;
	output reg [0:0] to_mem_waddr__en;
	output reg [2:0] to_mem_waddr__msg;
	input wire [0:0] to_mem_waddr__rdy;
	output reg [0:0] to_mem_wdata__en;
	output reg [33:0] to_mem_wdata__msg;
	input wire [0:0] to_mem_wdata__rdy;
	localparam [33:0] const_zero = 34'h000000000;
	localparam [31:0] __const__num_outports_at_update_signal = 32'd2;
	localparam [31:0] __const__num_inports_at_comb_logic = 32'd4;
	localparam [31:0] __const__num_outports_at_comb_logic = 32'd2;
	localparam [5:0] __const__OPT_MUL = 6'd7;
	localparam [5:0] __const__OPT_MUL_CONST = 6'd29;
	localparam [5:0] __const__OPT_DIV = 6'd26;
	reg [2:0] __tmpvar__comb_logic_in0;
	reg [2:0] __tmpvar__comb_logic_in1;
	always @(*) begin : comb_logic
		__tmpvar__comb_logic_in0 = 3'd0;
		__tmpvar__comb_logic_in1 = 3'd0;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__num_inports_at_comb_logic; i = i + 1)
				recv_in__rdy[3 - i+:1] = 1'd0;
		end
		recv_predicate__rdy = 1'd0;
		if (recv_opt__en) begin
			if (recv_opt__msg[40+:3] != 3'd0) begin
				__tmpvar__comb_logic_in0 = recv_opt__msg[40+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd1;
			end
			if (recv_opt__msg[43+:3] != 3'd0) begin
				__tmpvar__comb_logic_in1 = recv_opt__msg[43+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd1;
			end
			if (recv_opt__msg[52] == 1'd1)
				recv_predicate__rdy = 1'd1;
		end
		send_out__msg[35] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1] && recv_in__msg[((3 - __tmpvar__comb_logic_in1) * 34) + 1];
		begin : sv2v_autoblock_2
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				send_out__en[1 - j+:1] = recv_opt__en;
		end
		if (recv_opt__msg[58-:6] == __const__OPT_MUL) begin
			send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32] * recv_in__msg[((3 - __tmpvar__comb_logic_in1) * 34) + 33-:32];
			if (recv_opt__en && ((recv_in_count[(3 - __tmpvar__comb_logic_in0) * 2+:2] == 2'd0) || (recv_in_count[(3 - __tmpvar__comb_logic_in1) * 2+:2] == 2'd0))) begin
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd0;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd0;
				send_out__msg[35] = 1'd0;
			end
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_MUL_CONST) begin
			send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32] * recv_const__msg[33-:32];
			send_out__msg[35] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1];
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_DIV) begin
			send_out__msg[67-:32] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32] / recv_in__msg[((3 - __tmpvar__comb_logic_in1) * 34) + 33-:32];
			if (recv_opt__en && ((recv_in_count[(3 - __tmpvar__comb_logic_in0) * 2+:2] == 2'd0) || (recv_in_count[(3 - __tmpvar__comb_logic_in1) * 2+:2] == 2'd0))) begin
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd0;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd0;
				send_out__msg[35] = 1'd0;
			end
		end
		else begin : sv2v_autoblock_3
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				send_out__en[1 - j+:1] = 1'd0;
		end
		if (recv_opt__msg[52] == 1'd1)
			send_out__msg[35] = send_out__msg[35] && recv_predicate__msg[0];
	end
	always @(*) begin : update_mem
		to_mem_waddr__en = 1'd0;
		to_mem_wdata__en = 1'd0;
		to_mem_wdata__msg = const_zero;
		to_mem_waddr__msg = 3'd0;
		to_mem_raddr__msg = 3'd0;
		to_mem_raddr__en = 1'd0;
		from_mem_rdata__rdy = 1'd0;
	end
	always @(*) begin : update_signal
		begin : sv2v_autoblock_4
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_update_signal; j = j + 1)
				begin
					recv_const__rdy = send_out__rdy[1 - j+:1] || recv_const__rdy;
					recv_opt__rdy = send_out__rdy[1 - j+:1] || recv_opt__rdy;
				end
		end
	end
endmodule
module BranchRTL__a050676efb0a4b04 (
	clk,
	initial_carry_in,
	initial_carry_out,
	recv_in_count,
	reset,
	from_mem_rdata__en,
	from_mem_rdata__msg,
	from_mem_rdata__rdy,
	recv_const__en,
	recv_const__msg,
	recv_const__rdy,
	recv_in__en,
	recv_in__msg,
	recv_in__rdy,
	recv_opt__en,
	recv_opt__msg,
	recv_opt__rdy,
	recv_predicate__en,
	recv_predicate__msg,
	recv_predicate__rdy,
	send_out__en,
	send_out__msg,
	send_out__rdy,
	to_mem_raddr__en,
	to_mem_raddr__msg,
	to_mem_raddr__rdy,
	to_mem_waddr__en,
	to_mem_waddr__msg,
	to_mem_waddr__rdy,
	to_mem_wdata__en,
	to_mem_wdata__msg,
	to_mem_wdata__rdy
);
	input wire [0:0] clk;
	input wire [0:0] initial_carry_in;
	output wire [0:0] initial_carry_out;
	input wire [7:0] recv_in_count;
	input wire [0:0] reset;
	input wire [0:0] from_mem_rdata__en;
	input wire [33:0] from_mem_rdata__msg;
	output reg [0:0] from_mem_rdata__rdy;
	input wire [0:0] recv_const__en;
	input wire [33:0] recv_const__msg;
	output reg [0:0] recv_const__rdy;
	input wire [3:0] recv_in__en;
	input wire [135:0] recv_in__msg;
	output reg [3:0] recv_in__rdy;
	input wire [0:0] recv_opt__en;
	input wire [58:0] recv_opt__msg;
	output reg [0:0] recv_opt__rdy;
	input wire [0:0] recv_predicate__en;
	input wire [1:0] recv_predicate__msg;
	output reg [0:0] recv_predicate__rdy;
	output reg [1:0] send_out__en;
	output reg [67:0] send_out__msg;
	input wire [1:0] send_out__rdy;
	output reg [0:0] to_mem_raddr__en;
	output reg [2:0] to_mem_raddr__msg;
	input wire [0:0] to_mem_raddr__rdy;
	output reg [0:0] to_mem_waddr__en;
	output reg [2:0] to_mem_waddr__msg;
	input wire [0:0] to_mem_waddr__rdy;
	output reg [0:0] to_mem_wdata__en;
	output reg [33:0] to_mem_wdata__msg;
	input wire [0:0] to_mem_wdata__rdy;
	localparam [33:0] const_zero = 34'h000000000;
	localparam [31:0] __const__num_outports_at_update_signal = 32'd2;
	localparam [31:0] __const__num_inports_at_comb_logic = 32'd4;
	localparam [31:0] __const__num_outports_at_comb_logic = 32'd2;
	localparam [5:0] __const__OPT_BRH = 6'd16;
	localparam [5:0] __const__OPT_BRH_START = 6'd34;
	reg [0:0] first;
	reg [2:0] __tmpvar__comb_logic_in0;
	always @(*) begin : comb_logic
		__tmpvar__comb_logic_in0 = 3'd0;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__num_inports_at_comb_logic; i = i + 1)
				recv_in__rdy[3 - i+:1] = 1'd0;
		end
		recv_predicate__rdy = 1'd0;
		if (recv_opt__en) begin
			if (recv_opt__msg[40+:3] != 3'd0) begin
				__tmpvar__comb_logic_in0 = recv_opt__msg[40+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd1;
			end
			if (recv_opt__msg[52] == 1'd1)
				recv_predicate__rdy = 1'd1;
		end
		begin : sv2v_autoblock_2
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				send_out__en[1 - j+:1] = recv_opt__en;
		end
		if (recv_opt__msg[58-:6] == __const__OPT_BRH) begin
			send_out__msg[34+:34] = 34'h000000000;
			send_out__msg[0+:34] = 34'h000000000;
			if (recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32] == const_zero[33-:32]) begin
				send_out__msg[35] = 1'd1;
				send_out__msg[1] = 1'd0;
			end
			else begin
				send_out__msg[35] = 1'd0;
				send_out__msg[1] = 1'd1;
			end
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_BRH_START) begin
			send_out__msg[34+:34] = 34'h000000000;
			send_out__msg[0+:34] = 34'h000000000;
			if (first == 1'd1) begin
				send_out__msg[35] = 1'd1;
				send_out__msg[1] = 1'd0;
			end
			else begin
				send_out__msg[35] = 1'd0;
				send_out__msg[1] = 1'd1;
			end
		end
		else begin : sv2v_autoblock_3
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				send_out__en[1 - j+:1] = 1'd0;
		end
		if ((recv_opt__msg[52] == 1'd1) && (recv_opt__msg[58-:6] != __const__OPT_BRH_START)) begin
			send_out__msg[35] = send_out__msg[35] && recv_predicate__msg[0];
			send_out__msg[1] = send_out__msg[1] && recv_predicate__msg[0];
		end
	end
	always @(*) begin : update_mem
		to_mem_waddr__en = 1'd0;
		to_mem_wdata__en = 1'd0;
		to_mem_wdata__msg = const_zero;
		to_mem_waddr__msg = 3'd0;
		to_mem_raddr__msg = 3'd0;
		to_mem_raddr__en = 1'd0;
		from_mem_rdata__rdy = 1'd0;
	end
	always @(*) begin : update_signal
		begin : sv2v_autoblock_4
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_update_signal; j = j + 1)
				begin
					recv_const__rdy = send_out__rdy[1 - j+:1] || recv_const__rdy;
					recv_opt__rdy = send_out__rdy[1 - j+:1] || recv_opt__rdy;
				end
		end
	end
	always @(posedge clk) begin : br_start_once
		if (reset)
			first <= 1'd1;
		if (recv_opt__msg[58-:6] == __const__OPT_BRH_START)
			first <= 1'd0;
	end
endmodule
module MemUnitRTL__a050676efb0a4b04 (
	clk,
	initial_carry_in,
	initial_carry_out,
	recv_in_count,
	reset,
	from_mem_rdata__en,
	from_mem_rdata__msg,
	from_mem_rdata__rdy,
	recv_const__en,
	recv_const__msg,
	recv_const__rdy,
	recv_in__en,
	recv_in__msg,
	recv_in__rdy,
	recv_opt__en,
	recv_opt__msg,
	recv_opt__rdy,
	recv_predicate__en,
	recv_predicate__msg,
	recv_predicate__rdy,
	send_out__en,
	send_out__msg,
	send_out__rdy,
	to_mem_raddr__en,
	to_mem_raddr__msg,
	to_mem_raddr__rdy,
	to_mem_waddr__en,
	to_mem_waddr__msg,
	to_mem_waddr__rdy,
	to_mem_wdata__en,
	to_mem_wdata__msg,
	to_mem_wdata__rdy
);
	input wire [0:0] clk;
	input wire [0:0] initial_carry_in;
	output wire [0:0] initial_carry_out;
	input wire [7:0] recv_in_count;
	input wire [0:0] reset;
	input wire [0:0] from_mem_rdata__en;
	input wire [33:0] from_mem_rdata__msg;
	output reg [0:0] from_mem_rdata__rdy;
	input wire [0:0] recv_const__en;
	input wire [33:0] recv_const__msg;
	output reg [0:0] recv_const__rdy;
	input wire [3:0] recv_in__en;
	input wire [135:0] recv_in__msg;
	output reg [3:0] recv_in__rdy;
	input wire [0:0] recv_opt__en;
	input wire [58:0] recv_opt__msg;
	output reg [0:0] recv_opt__rdy;
	input wire [0:0] recv_predicate__en;
	input wire [1:0] recv_predicate__msg;
	output reg [0:0] recv_predicate__rdy;
	output reg [1:0] send_out__en;
	output reg [67:0] send_out__msg;
	input wire [1:0] send_out__rdy;
	output reg [0:0] to_mem_raddr__en;
	output reg [2:0] to_mem_raddr__msg;
	input wire [0:0] to_mem_raddr__rdy;
	output reg [0:0] to_mem_waddr__en;
	output reg [2:0] to_mem_waddr__msg;
	input wire [0:0] to_mem_waddr__rdy;
	output reg [0:0] to_mem_wdata__en;
	output reg [33:0] to_mem_wdata__msg;
	input wire [0:0] to_mem_wdata__rdy;
	localparam [31:0] __const__num_inports_at_comb_logic = 32'd4;
	localparam [31:0] __const__num_outports_at_comb_logic = 32'd2;
	localparam [5:0] __const__OPT_LD = 6'd12;
	localparam [5:0] __const__OPT_LD_CONST = 6'd28;
	localparam [5:0] __const__OPT_STR = 6'd13;
	reg [2:0] __tmpvar__comb_logic_in0;
	reg [2:0] __tmpvar__comb_logic_in1;
	function automatic [2:0] sv2v_cast_3;
		input reg [2:0] inp;
		sv2v_cast_3 = inp;
	endfunction
	always @(*) begin : comb_logic
		__tmpvar__comb_logic_in0 = 3'd0;
		__tmpvar__comb_logic_in1 = 3'd0;
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__num_inports_at_comb_logic; i = i + 1)
				recv_in__rdy[3 - i+:1] = 1'd0;
		end
		recv_predicate__rdy = 1'd0;
		if (recv_opt__en) begin
			if (recv_opt__msg[40+:3] != 3'd0) begin
				__tmpvar__comb_logic_in0 = recv_opt__msg[40+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd1;
			end
			if (recv_opt__msg[43+:3] != 3'd0) begin
				__tmpvar__comb_logic_in1 = recv_opt__msg[43+:3] - 3'd1;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd1;
			end
			if (recv_opt__msg[52] == 1'd1)
				recv_predicate__rdy = 1'd1;
		end
		begin : sv2v_autoblock_2
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				recv_const__rdy = send_out__rdy[1 - j+:1] || recv_const__rdy;
		end
		begin : sv2v_autoblock_3
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				recv_opt__rdy = send_out__rdy[1 - j+:1] || recv_opt__rdy;
		end
		begin : sv2v_autoblock_4
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				begin
					begin : sv2v_autoblock_5
						reg signed [31:0] i;
						for (i = 0; i < __const__num_inports_at_comb_logic; i = i + 1)
							send_out__en[1 - j+:1] = recv_in__en[3 - i+:1] || send_out__en[1 - j+:1];
					end
					send_out__en[1 - j+:1] = send_out__en[1 - j+:1] && recv_opt__en;
				end
		end
		send_out__msg[34+:34] = from_mem_rdata__msg;
		to_mem_waddr__en = 1'd0;
		to_mem_wdata__en = 1'd0;
		if (recv_opt__msg[58-:6] == __const__OPT_LD) begin
			recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = to_mem_raddr__rdy;
			recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = from_mem_rdata__rdy;
			to_mem_raddr__msg = sv2v_cast_3(recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 33-:32]);
			to_mem_raddr__en = recv_in__en[3 - __tmpvar__comb_logic_in0+:1];
			from_mem_rdata__rdy = send_out__rdy[1+:1];
			send_out__msg[34+:34] = from_mem_rdata__msg;
			send_out__en[1+:1] = recv_opt__en;
			send_out__msg[35] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1];
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_LD_CONST) begin
			begin : sv2v_autoblock_6
				reg signed [31:0] i;
				for (i = 0; i < __const__num_inports_at_comb_logic; i = i + 1)
					recv_in__rdy[3 - i+:1] = 1'd0;
			end
			recv_const__rdy = to_mem_raddr__rdy;
			to_mem_raddr__msg = sv2v_cast_3(recv_const__msg[33-:32]);
			to_mem_raddr__en = recv_const__en;
			from_mem_rdata__rdy = send_out__rdy[1+:1];
			send_out__msg[34+:34] = from_mem_rdata__msg;
			send_out__en[1+:1] = recv_opt__en;
			send_out__msg[35] = 1'd1;
		end
		else if (recv_opt__msg[58-:6] == __const__OPT_STR) begin
			send_out__en[1+:1] = (from_mem_rdata__en && recv_in__en[3 - __tmpvar__comb_logic_in0+:1]) && recv_in__en[3 - __tmpvar__comb_logic_in1+:1];
			recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = to_mem_waddr__rdy;
			recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = to_mem_wdata__rdy;
			to_mem_waddr__msg = sv2v_cast_3(recv_in__msg[135-:32]);
			to_mem_waddr__en = recv_in__en[3 - __tmpvar__comb_logic_in0+:1];
			to_mem_wdata__msg = recv_in__msg[(3 - __tmpvar__comb_logic_in1) * 34+:34];
			to_mem_wdata__en = recv_in__en[3 - __tmpvar__comb_logic_in1+:1];
			send_out__en[1+:1] = 1'd0;
			send_out__msg[34+:34] = from_mem_rdata__msg;
			send_out__msg[35] = recv_in__msg[((3 - __tmpvar__comb_logic_in0) * 34) + 1] && recv_in__msg[((3 - __tmpvar__comb_logic_in1) * 34) + 1];
			if (recv_opt__en && ((recv_in_count[(3 - __tmpvar__comb_logic_in0) * 2+:2] == 2'd0) || (recv_in_count[(3 - __tmpvar__comb_logic_in1) * 2+:2] == 2'd0))) begin
				recv_in__rdy[3 - __tmpvar__comb_logic_in0+:1] = 1'd0;
				recv_in__rdy[3 - __tmpvar__comb_logic_in1+:1] = 1'd0;
				send_out__msg[35] = 1'd0;
			end
		end
		else begin : sv2v_autoblock_7
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				send_out__en[1 - j+:1] = 1'd0;
		end
		if (recv_opt__msg[52] == 1'd1)
			send_out__msg[35] = send_out__msg[35] && recv_predicate__msg[0];
	end
endmodule
module FlexibleFuRTL__7ccad8d3ed73c188 (
	clk,
	recv_in_count,
	reset,
	from_mem_rdata__en,
	from_mem_rdata__msg,
	from_mem_rdata__rdy,
	recv_const__en,
	recv_const__msg,
	recv_const__rdy,
	recv_in__en,
	recv_in__msg,
	recv_in__rdy,
	recv_opt__en,
	recv_opt__msg,
	recv_opt__rdy,
	recv_predicate__en,
	recv_predicate__msg,
	recv_predicate__rdy,
	send_out__en,
	send_out__msg,
	send_out__rdy,
	to_mem_raddr__en,
	to_mem_raddr__msg,
	to_mem_raddr__rdy,
	to_mem_waddr__en,
	to_mem_waddr__msg,
	to_mem_waddr__rdy,
	to_mem_wdata__en,
	to_mem_wdata__msg,
	to_mem_wdata__rdy
);
	input wire [0:0] clk;
	input wire [7:0] recv_in_count;
	input wire [0:0] reset;
	input wire [5:0] from_mem_rdata__en;
	input wire [203:0] from_mem_rdata__msg;
	output wire [5:0] from_mem_rdata__rdy;
	input wire [0:0] recv_const__en;
	input wire [33:0] recv_const__msg;
	output reg [0:0] recv_const__rdy;
	input wire [3:0] recv_in__en;
	input wire [135:0] recv_in__msg;
	output reg [3:0] recv_in__rdy;
	input wire [0:0] recv_opt__en;
	input wire [58:0] recv_opt__msg;
	output reg [0:0] recv_opt__rdy;
	input wire [0:0] recv_predicate__en;
	input wire [1:0] recv_predicate__msg;
	output reg [0:0] recv_predicate__rdy;
	output reg [1:0] send_out__en;
	output reg [67:0] send_out__msg;
	input wire [1:0] send_out__rdy;
	output wire [5:0] to_mem_raddr__en;
	output wire [17:0] to_mem_raddr__msg;
	input wire [5:0] to_mem_raddr__rdy;
	output wire [5:0] to_mem_waddr__en;
	output wire [17:0] to_mem_waddr__msg;
	input wire [5:0] to_mem_waddr__rdy;
	output wire [5:0] to_mem_wdata__en;
	output wire [203:0] to_mem_wdata__msg;
	input wire [5:0] to_mem_wdata__rdy;
	localparam [31:0] fu_list_size = 32'd6;
	localparam [31:0] __const__num_outports_at_comb_logic = 32'd2;
	localparam [31:0] __const__num_inports_at_comb_logic = 32'd4;
	wire [0:0] fu__clk [0:5];
	wire [0:0] fu__initial_carry_in [0:5];
	wire [0:0] fu__initial_carry_out [0:5];
	reg [7:0] fu__recv_in_count [0:5];
	wire [0:0] fu__reset [0:5];
	wire [0:0] fu__from_mem_rdata__en [0:5];
	wire [33:0] fu__from_mem_rdata__msg [0:5];
	wire [0:0] fu__from_mem_rdata__rdy [0:5];
	reg [0:0] fu__recv_const__en [0:5];
	reg [33:0] fu__recv_const__msg [0:5];
	wire [0:0] fu__recv_const__rdy [0:5];
	reg [3:0] fu__recv_in__en [0:5];
	reg [135:0] fu__recv_in__msg [0:5];
	wire [3:0] fu__recv_in__rdy [0:5];
	reg [0:0] fu__recv_opt__en [0:5];
	reg [58:0] fu__recv_opt__msg [0:5];
	wire [0:0] fu__recv_opt__rdy [0:5];
	reg [0:0] fu__recv_predicate__en [0:5];
	reg [1:0] fu__recv_predicate__msg [0:5];
	wire [0:0] fu__recv_predicate__rdy [0:5];
	wire [1:0] fu__send_out__en [0:5];
	wire [67:0] fu__send_out__msg [0:5];
	reg [1:0] fu__send_out__rdy [0:5];
	wire [0:0] fu__to_mem_raddr__en [0:5];
	wire [2:0] fu__to_mem_raddr__msg [0:5];
	wire [0:0] fu__to_mem_raddr__rdy [0:5];
	wire [0:0] fu__to_mem_waddr__en [0:5];
	wire [2:0] fu__to_mem_waddr__msg [0:5];
	wire [0:0] fu__to_mem_waddr__rdy [0:5];
	wire [0:0] fu__to_mem_wdata__en [0:5];
	wire [33:0] fu__to_mem_wdata__msg [0:5];
	wire [0:0] fu__to_mem_wdata__rdy [0:5];
	PhiRTL__a050676efb0a4b04 fu__0(
		.clk(fu__clk[0]),
		.initial_carry_in(fu__initial_carry_in[0]),
		.initial_carry_out(fu__initial_carry_out[0]),
		.recv_in_count(fu__recv_in_count[0]),
		.reset(fu__reset[0]),
		.from_mem_rdata__en(fu__from_mem_rdata__en[0]),
		.from_mem_rdata__msg(fu__from_mem_rdata__msg[0]),
		.from_mem_rdata__rdy(fu__from_mem_rdata__rdy[0]),
		.recv_const__en(fu__recv_const__en[0]),
		.recv_const__msg(fu__recv_const__msg[0]),
		.recv_const__rdy(fu__recv_const__rdy[0]),
		.recv_in__en(fu__recv_in__en[0]),
		.recv_in__msg(fu__recv_in__msg[0]),
		.recv_in__rdy(fu__recv_in__rdy[0]),
		.recv_opt__en(fu__recv_opt__en[0]),
		.recv_opt__msg(fu__recv_opt__msg[0]),
		.recv_opt__rdy(fu__recv_opt__rdy[0]),
		.recv_predicate__en(fu__recv_predicate__en[0]),
		.recv_predicate__msg(fu__recv_predicate__msg[0]),
		.recv_predicate__rdy(fu__recv_predicate__rdy[0]),
		.send_out__en(fu__send_out__en[0]),
		.send_out__msg(fu__send_out__msg[0]),
		.send_out__rdy(fu__send_out__rdy[0]),
		.to_mem_raddr__en(fu__to_mem_raddr__en[0]),
		.to_mem_raddr__msg(fu__to_mem_raddr__msg[0]),
		.to_mem_raddr__rdy(fu__to_mem_raddr__rdy[0]),
		.to_mem_waddr__en(fu__to_mem_waddr__en[0]),
		.to_mem_waddr__msg(fu__to_mem_waddr__msg[0]),
		.to_mem_waddr__rdy(fu__to_mem_waddr__rdy[0]),
		.to_mem_wdata__en(fu__to_mem_wdata__en[0]),
		.to_mem_wdata__msg(fu__to_mem_wdata__msg[0]),
		.to_mem_wdata__rdy(fu__to_mem_wdata__rdy[0])
	);
	AdderRTL__a050676efb0a4b04 fu__1(
		.clk(fu__clk[1]),
		.initial_carry_in(fu__initial_carry_in[1]),
		.initial_carry_out(fu__initial_carry_out[1]),
		.recv_in_count(fu__recv_in_count[1]),
		.reset(fu__reset[1]),
		.from_mem_rdata__en(fu__from_mem_rdata__en[1]),
		.from_mem_rdata__msg(fu__from_mem_rdata__msg[1]),
		.from_mem_rdata__rdy(fu__from_mem_rdata__rdy[1]),
		.recv_const__en(fu__recv_const__en[1]),
		.recv_const__msg(fu__recv_const__msg[1]),
		.recv_const__rdy(fu__recv_const__rdy[1]),
		.recv_in__en(fu__recv_in__en[1]),
		.recv_in__msg(fu__recv_in__msg[1]),
		.recv_in__rdy(fu__recv_in__rdy[1]),
		.recv_opt__en(fu__recv_opt__en[1]),
		.recv_opt__msg(fu__recv_opt__msg[1]),
		.recv_opt__rdy(fu__recv_opt__rdy[1]),
		.recv_predicate__en(fu__recv_predicate__en[1]),
		.recv_predicate__msg(fu__recv_predicate__msg[1]),
		.recv_predicate__rdy(fu__recv_predicate__rdy[1]),
		.send_out__en(fu__send_out__en[1]),
		.send_out__msg(fu__send_out__msg[1]),
		.send_out__rdy(fu__send_out__rdy[1]),
		.to_mem_raddr__en(fu__to_mem_raddr__en[1]),
		.to_mem_raddr__msg(fu__to_mem_raddr__msg[1]),
		.to_mem_raddr__rdy(fu__to_mem_raddr__rdy[1]),
		.to_mem_waddr__en(fu__to_mem_waddr__en[1]),
		.to_mem_waddr__msg(fu__to_mem_waddr__msg[1]),
		.to_mem_waddr__rdy(fu__to_mem_waddr__rdy[1]),
		.to_mem_wdata__en(fu__to_mem_wdata__en[1]),
		.to_mem_wdata__msg(fu__to_mem_wdata__msg[1]),
		.to_mem_wdata__rdy(fu__to_mem_wdata__rdy[1])
	);
	CompRTL__a050676efb0a4b04 fu__2(
		.clk(fu__clk[2]),
		.initial_carry_in(fu__initial_carry_in[2]),
		.initial_carry_out(fu__initial_carry_out[2]),
		.recv_in_count(fu__recv_in_count[2]),
		.reset(fu__reset[2]),
		.from_mem_rdata__en(fu__from_mem_rdata__en[2]),
		.from_mem_rdata__msg(fu__from_mem_rdata__msg[2]),
		.from_mem_rdata__rdy(fu__from_mem_rdata__rdy[2]),
		.recv_const__en(fu__recv_const__en[2]),
		.recv_const__msg(fu__recv_const__msg[2]),
		.recv_const__rdy(fu__recv_const__rdy[2]),
		.recv_in__en(fu__recv_in__en[2]),
		.recv_in__msg(fu__recv_in__msg[2]),
		.recv_in__rdy(fu__recv_in__rdy[2]),
		.recv_opt__en(fu__recv_opt__en[2]),
		.recv_opt__msg(fu__recv_opt__msg[2]),
		.recv_opt__rdy(fu__recv_opt__rdy[2]),
		.recv_predicate__en(fu__recv_predicate__en[2]),
		.recv_predicate__msg(fu__recv_predicate__msg[2]),
		.recv_predicate__rdy(fu__recv_predicate__rdy[2]),
		.send_out__en(fu__send_out__en[2]),
		.send_out__msg(fu__send_out__msg[2]),
		.send_out__rdy(fu__send_out__rdy[2]),
		.to_mem_raddr__en(fu__to_mem_raddr__en[2]),
		.to_mem_raddr__msg(fu__to_mem_raddr__msg[2]),
		.to_mem_raddr__rdy(fu__to_mem_raddr__rdy[2]),
		.to_mem_waddr__en(fu__to_mem_waddr__en[2]),
		.to_mem_waddr__msg(fu__to_mem_waddr__msg[2]),
		.to_mem_waddr__rdy(fu__to_mem_waddr__rdy[2]),
		.to_mem_wdata__en(fu__to_mem_wdata__en[2]),
		.to_mem_wdata__msg(fu__to_mem_wdata__msg[2]),
		.to_mem_wdata__rdy(fu__to_mem_wdata__rdy[2])
	);
	MulRTL__a050676efb0a4b04 fu__3(
		.clk(fu__clk[3]),
		.initial_carry_in(fu__initial_carry_in[3]),
		.initial_carry_out(fu__initial_carry_out[3]),
		.recv_in_count(fu__recv_in_count[3]),
		.reset(fu__reset[3]),
		.from_mem_rdata__en(fu__from_mem_rdata__en[3]),
		.from_mem_rdata__msg(fu__from_mem_rdata__msg[3]),
		.from_mem_rdata__rdy(fu__from_mem_rdata__rdy[3]),
		.recv_const__en(fu__recv_const__en[3]),
		.recv_const__msg(fu__recv_const__msg[3]),
		.recv_const__rdy(fu__recv_const__rdy[3]),
		.recv_in__en(fu__recv_in__en[3]),
		.recv_in__msg(fu__recv_in__msg[3]),
		.recv_in__rdy(fu__recv_in__rdy[3]),
		.recv_opt__en(fu__recv_opt__en[3]),
		.recv_opt__msg(fu__recv_opt__msg[3]),
		.recv_opt__rdy(fu__recv_opt__rdy[3]),
		.recv_predicate__en(fu__recv_predicate__en[3]),
		.recv_predicate__msg(fu__recv_predicate__msg[3]),
		.recv_predicate__rdy(fu__recv_predicate__rdy[3]),
		.send_out__en(fu__send_out__en[3]),
		.send_out__msg(fu__send_out__msg[3]),
		.send_out__rdy(fu__send_out__rdy[3]),
		.to_mem_raddr__en(fu__to_mem_raddr__en[3]),
		.to_mem_raddr__msg(fu__to_mem_raddr__msg[3]),
		.to_mem_raddr__rdy(fu__to_mem_raddr__rdy[3]),
		.to_mem_waddr__en(fu__to_mem_waddr__en[3]),
		.to_mem_waddr__msg(fu__to_mem_waddr__msg[3]),
		.to_mem_waddr__rdy(fu__to_mem_waddr__rdy[3]),
		.to_mem_wdata__en(fu__to_mem_wdata__en[3]),
		.to_mem_wdata__msg(fu__to_mem_wdata__msg[3]),
		.to_mem_wdata__rdy(fu__to_mem_wdata__rdy[3])
	);
	BranchRTL__a050676efb0a4b04 fu__4(
		.clk(fu__clk[4]),
		.initial_carry_in(fu__initial_carry_in[4]),
		.initial_carry_out(fu__initial_carry_out[4]),
		.recv_in_count(fu__recv_in_count[4]),
		.reset(fu__reset[4]),
		.from_mem_rdata__en(fu__from_mem_rdata__en[4]),
		.from_mem_rdata__msg(fu__from_mem_rdata__msg[4]),
		.from_mem_rdata__rdy(fu__from_mem_rdata__rdy[4]),
		.recv_const__en(fu__recv_const__en[4]),
		.recv_const__msg(fu__recv_const__msg[4]),
		.recv_const__rdy(fu__recv_const__rdy[4]),
		.recv_in__en(fu__recv_in__en[4]),
		.recv_in__msg(fu__recv_in__msg[4]),
		.recv_in__rdy(fu__recv_in__rdy[4]),
		.recv_opt__en(fu__recv_opt__en[4]),
		.recv_opt__msg(fu__recv_opt__msg[4]),
		.recv_opt__rdy(fu__recv_opt__rdy[4]),
		.recv_predicate__en(fu__recv_predicate__en[4]),
		.recv_predicate__msg(fu__recv_predicate__msg[4]),
		.recv_predicate__rdy(fu__recv_predicate__rdy[4]),
		.send_out__en(fu__send_out__en[4]),
		.send_out__msg(fu__send_out__msg[4]),
		.send_out__rdy(fu__send_out__rdy[4]),
		.to_mem_raddr__en(fu__to_mem_raddr__en[4]),
		.to_mem_raddr__msg(fu__to_mem_raddr__msg[4]),
		.to_mem_raddr__rdy(fu__to_mem_raddr__rdy[4]),
		.to_mem_waddr__en(fu__to_mem_waddr__en[4]),
		.to_mem_waddr__msg(fu__to_mem_waddr__msg[4]),
		.to_mem_waddr__rdy(fu__to_mem_waddr__rdy[4]),
		.to_mem_wdata__en(fu__to_mem_wdata__en[4]),
		.to_mem_wdata__msg(fu__to_mem_wdata__msg[4]),
		.to_mem_wdata__rdy(fu__to_mem_wdata__rdy[4])
	);
	MemUnitRTL__a050676efb0a4b04 fu__5(
		.clk(fu__clk[5]),
		.initial_carry_in(fu__initial_carry_in[5]),
		.initial_carry_out(fu__initial_carry_out[5]),
		.recv_in_count(fu__recv_in_count[5]),
		.reset(fu__reset[5]),
		.from_mem_rdata__en(fu__from_mem_rdata__en[5]),
		.from_mem_rdata__msg(fu__from_mem_rdata__msg[5]),
		.from_mem_rdata__rdy(fu__from_mem_rdata__rdy[5]),
		.recv_const__en(fu__recv_const__en[5]),
		.recv_const__msg(fu__recv_const__msg[5]),
		.recv_const__rdy(fu__recv_const__rdy[5]),
		.recv_in__en(fu__recv_in__en[5]),
		.recv_in__msg(fu__recv_in__msg[5]),
		.recv_in__rdy(fu__recv_in__rdy[5]),
		.recv_opt__en(fu__recv_opt__en[5]),
		.recv_opt__msg(fu__recv_opt__msg[5]),
		.recv_opt__rdy(fu__recv_opt__rdy[5]),
		.recv_predicate__en(fu__recv_predicate__en[5]),
		.recv_predicate__msg(fu__recv_predicate__msg[5]),
		.recv_predicate__rdy(fu__recv_predicate__rdy[5]),
		.send_out__en(fu__send_out__en[5]),
		.send_out__msg(fu__send_out__msg[5]),
		.send_out__rdy(fu__send_out__rdy[5]),
		.to_mem_raddr__en(fu__to_mem_raddr__en[5]),
		.to_mem_raddr__msg(fu__to_mem_raddr__msg[5]),
		.to_mem_raddr__rdy(fu__to_mem_raddr__rdy[5]),
		.to_mem_waddr__en(fu__to_mem_waddr__en[5]),
		.to_mem_waddr__msg(fu__to_mem_waddr__msg[5]),
		.to_mem_waddr__rdy(fu__to_mem_waddr__rdy[5]),
		.to_mem_wdata__en(fu__to_mem_wdata__en[5]),
		.to_mem_wdata__msg(fu__to_mem_wdata__msg[5]),
		.to_mem_wdata__rdy(fu__to_mem_wdata__rdy[5])
	);
	always @(*) begin : comb_logic
		begin : sv2v_autoblock_1
			reg signed [31:0] j;
			for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
				send_out__en[1 - j+:1] = 1'd0;
		end
		begin : sv2v_autoblock_2
			reg signed [31:0] i;
			for (i = 0; i < fu_list_size; i = i + 1)
				begin
					fu__recv_const__msg[i] = recv_const__msg;
					fu__recv_const__en[i] = recv_const__en;
					recv_const__rdy = recv_const__rdy || fu__recv_const__rdy[i];
					begin : sv2v_autoblock_3
						reg signed [31:0] j;
						for (j = 0; j < __const__num_inports_at_comb_logic; j = j + 1)
							fu__recv_in_count[i][(3 - j) * 2+:2] = recv_in_count[(3 - j) * 2+:2];
					end
					fu__recv_opt__msg[i] = recv_opt__msg;
					fu__recv_opt__en[i] = recv_opt__en;
					recv_opt__rdy = fu__recv_opt__rdy[i] || recv_opt__rdy;
					fu__recv_opt__msg[i][52] = recv_opt__msg[52];
					fu__recv_predicate__en[i] = recv_predicate__en;
					recv_predicate__rdy = fu__recv_predicate__rdy[i] || recv_predicate__rdy;
					fu__recv_predicate__msg[i] = recv_predicate__msg;
					begin : sv2v_autoblock_4
						reg signed [31:0] j;
						for (j = 0; j < __const__num_outports_at_comb_logic; j = j + 1)
							begin
								if (fu__send_out__en[i][1 - j+:1]) begin
									send_out__msg[(1 - j) * 34+:34] = fu__send_out__msg[i][(1 - j) * 34+:34];
									send_out__en[1 - j+:1] = fu__send_out__en[i][1 - j+:1];
								end
								fu__send_out__rdy[i][1 - j+:1] = send_out__rdy[1 - j+:1];
							end
					end
				end
		end
		begin : sv2v_autoblock_5
			reg signed [31:0] j;
			for (j = 0; j < __const__num_inports_at_comb_logic; j = j + 1)
				recv_in__rdy[3 - j+:1] = 1'd0;
		end
		begin : sv2v_autoblock_6
			reg signed [31:0] i;
			for (i = 0; i < fu_list_size; i = i + 1)
				begin : sv2v_autoblock_7
					reg signed [31:0] j;
					for (j = 0; j < __const__num_inports_at_comb_logic; j = j + 1)
						begin
							fu__recv_in__msg[i][(3 - j) * 34+:34] = recv_in__msg[(3 - j) * 34+:34];
							fu__recv_in__en[i][3 - j+:1] = recv_in__en[3 - j+:1];
							recv_in__rdy[3 - j+:1] = fu__recv_in__rdy[i][3 - j+:1] || recv_in__rdy[3 - j+:1];
						end
				end
		end
	end
	assign fu__clk[0] = clk;
	assign fu__reset[0] = reset;
	assign fu__clk[1] = clk;
	assign fu__reset[1] = reset;
	assign fu__clk[2] = clk;
	assign fu__reset[2] = reset;
	assign fu__clk[3] = clk;
	assign fu__reset[3] = reset;
	assign fu__clk[4] = clk;
	assign fu__reset[4] = reset;
	assign fu__clk[5] = clk;
	assign fu__reset[5] = reset;
	assign to_mem_raddr__en[5+:1] = fu__to_mem_raddr__en[0];
	assign to_mem_raddr__msg[15+:3] = fu__to_mem_raddr__msg[0];
	assign fu__to_mem_raddr__rdy[0] = to_mem_raddr__rdy[5+:1];
	assign fu__from_mem_rdata__en[0] = from_mem_rdata__en[5+:1];
	assign fu__from_mem_rdata__msg[0] = from_mem_rdata__msg[170+:34];
	assign from_mem_rdata__rdy[5+:1] = fu__from_mem_rdata__rdy[0];
	assign to_mem_waddr__en[5+:1] = fu__to_mem_waddr__en[0];
	assign to_mem_waddr__msg[15+:3] = fu__to_mem_waddr__msg[0];
	assign fu__to_mem_waddr__rdy[0] = to_mem_waddr__rdy[5+:1];
	assign to_mem_wdata__en[5+:1] = fu__to_mem_wdata__en[0];
	assign to_mem_wdata__msg[170+:34] = fu__to_mem_wdata__msg[0];
	assign fu__to_mem_wdata__rdy[0] = to_mem_wdata__rdy[5+:1];
	assign to_mem_raddr__en[4+:1] = fu__to_mem_raddr__en[1];
	assign to_mem_raddr__msg[12+:3] = fu__to_mem_raddr__msg[1];
	assign fu__to_mem_raddr__rdy[1] = to_mem_raddr__rdy[4+:1];
	assign fu__from_mem_rdata__en[1] = from_mem_rdata__en[4+:1];
	assign fu__from_mem_rdata__msg[1] = from_mem_rdata__msg[136+:34];
	assign from_mem_rdata__rdy[4+:1] = fu__from_mem_rdata__rdy[1];
	assign to_mem_waddr__en[4+:1] = fu__to_mem_waddr__en[1];
	assign to_mem_waddr__msg[12+:3] = fu__to_mem_waddr__msg[1];
	assign fu__to_mem_waddr__rdy[1] = to_mem_waddr__rdy[4+:1];
	assign to_mem_wdata__en[4+:1] = fu__to_mem_wdata__en[1];
	assign to_mem_wdata__msg[136+:34] = fu__to_mem_wdata__msg[1];
	assign fu__to_mem_wdata__rdy[1] = to_mem_wdata__rdy[4+:1];
	assign to_mem_raddr__en[3+:1] = fu__to_mem_raddr__en[2];
	assign to_mem_raddr__msg[9+:3] = fu__to_mem_raddr__msg[2];
	assign fu__to_mem_raddr__rdy[2] = to_mem_raddr__rdy[3+:1];
	assign fu__from_mem_rdata__en[2] = from_mem_rdata__en[3+:1];
	assign fu__from_mem_rdata__msg[2] = from_mem_rdata__msg[102+:34];
	assign from_mem_rdata__rdy[3+:1] = fu__from_mem_rdata__rdy[2];
	assign to_mem_waddr__en[3+:1] = fu__to_mem_waddr__en[2];
	assign to_mem_waddr__msg[9+:3] = fu__to_mem_waddr__msg[2];
	assign fu__to_mem_waddr__rdy[2] = to_mem_waddr__rdy[3+:1];
	assign to_mem_wdata__en[3+:1] = fu__to_mem_wdata__en[2];
	assign to_mem_wdata__msg[102+:34] = fu__to_mem_wdata__msg[2];
	assign fu__to_mem_wdata__rdy[2] = to_mem_wdata__rdy[3+:1];
	assign to_mem_raddr__en[2+:1] = fu__to_mem_raddr__en[3];
	assign to_mem_raddr__msg[6+:3] = fu__to_mem_raddr__msg[3];
	assign fu__to_mem_raddr__rdy[3] = to_mem_raddr__rdy[2+:1];
	assign fu__from_mem_rdata__en[3] = from_mem_rdata__en[2+:1];
	assign fu__from_mem_rdata__msg[3] = from_mem_rdata__msg[68+:34];
	assign from_mem_rdata__rdy[2+:1] = fu__from_mem_rdata__rdy[3];
	assign to_mem_waddr__en[2+:1] = fu__to_mem_waddr__en[3];
	assign to_mem_waddr__msg[6+:3] = fu__to_mem_waddr__msg[3];
	assign fu__to_mem_waddr__rdy[3] = to_mem_waddr__rdy[2+:1];
	assign to_mem_wdata__en[2+:1] = fu__to_mem_wdata__en[3];
	assign to_mem_wdata__msg[68+:34] = fu__to_mem_wdata__msg[3];
	assign fu__to_mem_wdata__rdy[3] = to_mem_wdata__rdy[2+:1];
	assign to_mem_raddr__en[1+:1] = fu__to_mem_raddr__en[4];
	assign to_mem_raddr__msg[3+:3] = fu__to_mem_raddr__msg[4];
	assign fu__to_mem_raddr__rdy[4] = to_mem_raddr__rdy[1+:1];
	assign fu__from_mem_rdata__en[4] = from_mem_rdata__en[1+:1];
	assign fu__from_mem_rdata__msg[4] = from_mem_rdata__msg[34+:34];
	assign from_mem_rdata__rdy[1+:1] = fu__from_mem_rdata__rdy[4];
	assign to_mem_waddr__en[1+:1] = fu__to_mem_waddr__en[4];
	assign to_mem_waddr__msg[3+:3] = fu__to_mem_waddr__msg[4];
	assign fu__to_mem_waddr__rdy[4] = to_mem_waddr__rdy[1+:1];
	assign to_mem_wdata__en[1+:1] = fu__to_mem_wdata__en[4];
	assign to_mem_wdata__msg[34+:34] = fu__to_mem_wdata__msg[4];
	assign fu__to_mem_wdata__rdy[4] = to_mem_wdata__rdy[1+:1];
	assign to_mem_raddr__en[0+:1] = fu__to_mem_raddr__en[5];
	assign to_mem_raddr__msg[0+:3] = fu__to_mem_raddr__msg[5];
	assign fu__to_mem_raddr__rdy[5] = to_mem_raddr__rdy[0+:1];
	assign fu__from_mem_rdata__en[5] = from_mem_rdata__en[0+:1];
	assign fu__from_mem_rdata__msg[5] = from_mem_rdata__msg[0+:34];
	assign from_mem_rdata__rdy[0+:1] = fu__from_mem_rdata__rdy[5];
	assign to_mem_waddr__en[0+:1] = fu__to_mem_waddr__en[5];
	assign to_mem_waddr__msg[0+:3] = fu__to_mem_waddr__msg[5];
	assign fu__to_mem_waddr__rdy[5] = to_mem_waddr__rdy[0+:1];
	assign to_mem_wdata__en[0+:1] = fu__to_mem_wdata__en[5];
	assign to_mem_wdata__msg[0+:34] = fu__to_mem_wdata__msg[5];
	assign fu__to_mem_wdata__rdy[5] = to_mem_wdata__rdy[0+:1];
endmodule
module RegisterFile__b2651f5e70154f41 (
	clk,
	raddr,
	rdata,
	reset,
	waddr,
	wdata,
	wen
);
	input wire [0:0] clk;
	input wire [0:0] raddr;
	output reg [1:0] rdata;
	input wire [0:0] reset;
	input wire [0:0] waddr;
	input wire [1:0] wdata;
	input wire [0:0] wen;
	localparam [31:0] __const__rd_ports_at_up_rf_read = 32'd1;
	localparam [31:0] __const__wr_ports_at_up_rf_write = 32'd1;
	reg [1:0] regs [0:1];
	always @(*) begin : up_rf_read
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < __const__rd_ports_at_up_rf_read; i = i + 1)
				rdata[i * 2+:2] = regs[raddr[i+:1]];
		end
	end
	always @(posedge clk) begin : up_rf_write
		begin : sv2v_autoblock_2
			reg signed [31:0] i;
			for (i = 0; i < __const__wr_ports_at_up_rf_write; i = i + 1)
				if (wen[i+:1])
					regs[waddr[i+:1]] <= wdata[i * 2+:2];
		end
	end
endmodule
module NormalQueueDpathRTL__EntryType_CGRAData_1_1__num_entries_2 (
	clk,
	deq_ret,
	enq_msg,
	raddr,
	reset,
	waddr,
	wen
);
	input wire [0:0] clk;
	output wire [1:0] deq_ret;
	input wire [1:0] enq_msg;
	input wire [0:0] raddr;
	input wire [0:0] reset;
	input wire [0:0] waddr;
	input wire [0:0] wen;
	wire [0:0] queue__clk;
	wire [0:0] queue__raddr;
	wire [1:0] queue__rdata;
	wire [0:0] queue__reset;
	wire [0:0] queue__waddr;
	wire [1:0] queue__wdata;
	wire [0:0] queue__wen;
	RegisterFile__b2651f5e70154f41 queue(
		.clk(queue__clk),
		.raddr(queue__raddr),
		.rdata(queue__rdata),
		.reset(queue__reset),
		.waddr(queue__waddr),
		.wdata(queue__wdata),
		.wen(queue__wen)
	);
	assign queue__clk = clk;
	assign queue__reset = reset;
	assign queue__raddr[0+:1] = raddr;
	assign deq_ret = queue__rdata[0+:2];
	assign queue__wen[0+:1] = wen;
	assign queue__waddr[0+:1] = waddr;
	assign queue__wdata[0+:2] = enq_msg;
endmodule
module NormalQueueRTL__EntryType_CGRAData_1_1__num_entries_2 (
	clk,
	count,
	reset,
	deq__en,
	deq__rdy,
	deq__ret,
	enq__en,
	enq__msg,
	enq__rdy
);
	input wire [0:0] clk;
	output wire [1:0] count;
	input wire [0:0] reset;
	input wire [0:0] deq__en;
	output wire [0:0] deq__rdy;
	output wire [1:0] deq__ret;
	input wire [0:0] enq__en;
	input wire [1:0] enq__msg;
	output wire [0:0] enq__rdy;
	wire [0:0] ctrl__clk;
	wire [1:0] ctrl__count;
	wire [0:0] ctrl__deq_en;
	wire [0:0] ctrl__deq_rdy;
	wire [0:0] ctrl__enq_en;
	wire [0:0] ctrl__enq_rdy;
	wire [0:0] ctrl__raddr;
	wire [0:0] ctrl__reset;
	wire [0:0] ctrl__waddr;
	wire [0:0] ctrl__wen;
	NormalQueueCtrlRTL__num_entries_2 ctrl(
		.clk(ctrl__clk),
		.count(ctrl__count),
		.deq_en(ctrl__deq_en),
		.deq_rdy(ctrl__deq_rdy),
		.enq_en(ctrl__enq_en),
		.enq_rdy(ctrl__enq_rdy),
		.raddr(ctrl__raddr),
		.reset(ctrl__reset),
		.waddr(ctrl__waddr),
		.wen(ctrl__wen)
	);
	wire [0:0] dpath__clk;
	wire [1:0] dpath__deq_ret;
	wire [1:0] dpath__enq_msg;
	wire [0:0] dpath__raddr;
	wire [0:0] dpath__reset;
	wire [0:0] dpath__waddr;
	wire [0:0] dpath__wen;
	NormalQueueDpathRTL__EntryType_CGRAData_1_1__num_entries_2 dpath(
		.clk(dpath__clk),
		.deq_ret(dpath__deq_ret),
		.enq_msg(dpath__enq_msg),
		.raddr(dpath__raddr),
		.reset(dpath__reset),
		.waddr(dpath__waddr),
		.wen(dpath__wen)
	);
	assign ctrl__clk = clk;
	assign ctrl__reset = reset;
	assign dpath__clk = clk;
	assign dpath__reset = reset;
	assign dpath__wen = ctrl__wen;
	assign dpath__waddr = ctrl__waddr;
	assign dpath__raddr = ctrl__raddr;
	assign ctrl__enq_en = enq__en;
	assign enq__rdy = ctrl__enq_rdy;
	assign ctrl__deq_en = deq__en;
	assign deq__rdy = ctrl__deq_rdy;
	assign count = ctrl__count;
	assign dpath__enq_msg = enq__msg;
	assign deq__ret = dpath__deq_ret;
endmodule
module RegisterRTL__DataType_CGRAData_1_1__latency_1 (
	clk,
	reset,
	recv__en,
	recv__msg,
	recv__rdy,
	send__en,
	send__msg,
	send__rdy
);
	input wire [0:0] clk;
	input wire [0:0] reset;
	input wire [0:0] recv__en;
	input wire [1:0] recv__msg;
	output reg [0:0] recv__rdy;
	output reg [0:0] send__en;
	output reg [1:0] send__msg;
	input wire [0:0] send__rdy;
	localparam [31:0] latency = 32'd1;
	wire [0:0] queues__clk [0:0];
	wire [1:0] queues__count [0:0];
	wire [0:0] queues__reset [0:0];
	reg [0:0] queues__deq__en [0:0];
	wire [0:0] queues__deq__rdy [0:0];
	wire [1:0] queues__deq__ret [0:0];
	reg [0:0] queues__enq__en [0:0];
	reg [1:0] queues__enq__msg [0:0];
	wire [0:0] queues__enq__rdy [0:0];
	NormalQueueRTL__EntryType_CGRAData_1_1__num_entries_2 queues__0(
		.clk(queues__clk[0]),
		.count(queues__count[0]),
		.reset(queues__reset[0]),
		.deq__en(queues__deq__en[0]),
		.deq__rdy(queues__deq__rdy[0]),
		.deq__ret(queues__deq__ret[0]),
		.enq__en(queues__enq__en[0]),
		.enq__msg(queues__enq__msg[0]),
		.enq__rdy(queues__enq__rdy[0])
	);
	always @(*) begin : process
		recv__rdy = queues__enq__rdy[0];
		queues__enq__msg[0] = recv__msg;
		queues__enq__en[0] = recv__en && queues__enq__rdy[0];
		begin : sv2v_autoblock_1
			reg signed [31:0] i;
			for (i = 0; i < 0; i = i + 1)
				begin
					queues__enq__msg[i + 1] = queues__deq__ret[i];
					queues__enq__en[i + 1] = queues__deq__rdy[i] && queues__enq__rdy[i + 1];
					queues__deq__en[i] = queues__enq__en[i + 1];
				end
		end
		send__msg = queues__deq__ret[0];
		send__en = send__rdy && queues__deq__rdy[0];
		queues__deq__en[0] = send__en;
	end
	assign queues__clk[0] = clk;
	assign queues__reset[0] = reset;
endmodule
module TileRTL__40947ac956b390e0 (
	clk,
	reset,
	from_mem_rdata__en,
	from_mem_rdata__msg,
	from_mem_rdata__rdy,
	recv_data__en,
	recv_data__msg,
	recv_data__rdy,
	recv_waddr__en,
	recv_waddr__msg,
	recv_waddr__rdy,
	recv_wopt__en,
	recv_wopt__msg,
	recv_wopt__rdy,
	send_data__en,
	send_data__msg,
	send_data__rdy,
	to_mem_raddr__en,
	to_mem_raddr__msg,
	to_mem_raddr__rdy,
	to_mem_waddr__en,
	to_mem_waddr__msg,
	to_mem_waddr__rdy,
	to_mem_wdata__en,
	to_mem_wdata__msg,
	to_mem_wdata__rdy
);
	input wire [0:0] clk;
	input wire [0:0] reset;
	input wire [0:0] from_mem_rdata__en;
	input wire [33:0] from_mem_rdata__msg;
	output wire [0:0] from_mem_rdata__rdy;
	input wire [7:0] recv_data__en;
	input wire [271:0] recv_data__msg;
	output wire [7:0] recv_data__rdy;
	input wire [0:0] recv_waddr__en;
	input wire [2:0] recv_waddr__msg;
	output wire [0:0] recv_waddr__rdy;
	input wire [0:0] recv_wopt__en;
	input wire [58:0] recv_wopt__msg;
	output wire [0:0] recv_wopt__rdy;
	output wire [7:0] send_data__en;
	output wire [271:0] send_data__msg;
	input wire [7:0] send_data__rdy;
	output wire [0:0] to_mem_raddr__en;
	output wire [2:0] to_mem_raddr__msg;
	input wire [0:0] to_mem_raddr__rdy;
	output wire [0:0] to_mem_waddr__en;
	output wire [2:0] to_mem_waddr__msg;
	input wire [0:0] to_mem_waddr__rdy;
	output wire [0:0] to_mem_wdata__en;
	output wire [33:0] to_mem_wdata__msg;
	input wire [0:0] to_mem_wdata__rdy;
	wire [0:0] channel__clk [0:11];
	wire [1:0] channel__count [0:11];
	wire [0:0] channel__reset [0:11];
	wire [0:0] channel__recv__en [0:11];
	wire [33:0] channel__recv__msg [0:11];
	wire [0:0] channel__recv__rdy [0:11];
	wire [0:0] channel__send__en [0:11];
	wire [33:0] channel__send__msg [0:11];
	wire [0:0] channel__send__rdy [0:11];
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__0(
		.clk(channel__clk[0]),
		.count(channel__count[0]),
		.reset(channel__reset[0]),
		.recv__en(channel__recv__en[0]),
		.recv__msg(channel__recv__msg[0]),
		.recv__rdy(channel__recv__rdy[0]),
		.send__en(channel__send__en[0]),
		.send__msg(channel__send__msg[0]),
		.send__rdy(channel__send__rdy[0])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__1(
		.clk(channel__clk[1]),
		.count(channel__count[1]),
		.reset(channel__reset[1]),
		.recv__en(channel__recv__en[1]),
		.recv__msg(channel__recv__msg[1]),
		.recv__rdy(channel__recv__rdy[1]),
		.send__en(channel__send__en[1]),
		.send__msg(channel__send__msg[1]),
		.send__rdy(channel__send__rdy[1])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__2(
		.clk(channel__clk[2]),
		.count(channel__count[2]),
		.reset(channel__reset[2]),
		.recv__en(channel__recv__en[2]),
		.recv__msg(channel__recv__msg[2]),
		.recv__rdy(channel__recv__rdy[2]),
		.send__en(channel__send__en[2]),
		.send__msg(channel__send__msg[2]),
		.send__rdy(channel__send__rdy[2])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__3(
		.clk(channel__clk[3]),
		.count(channel__count[3]),
		.reset(channel__reset[3]),
		.recv__en(channel__recv__en[3]),
		.recv__msg(channel__recv__msg[3]),
		.recv__rdy(channel__recv__rdy[3]),
		.send__en(channel__send__en[3]),
		.send__msg(channel__send__msg[3]),
		.send__rdy(channel__send__rdy[3])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__4(
		.clk(channel__clk[4]),
		.count(channel__count[4]),
		.reset(channel__reset[4]),
		.recv__en(channel__recv__en[4]),
		.recv__msg(channel__recv__msg[4]),
		.recv__rdy(channel__recv__rdy[4]),
		.send__en(channel__send__en[4]),
		.send__msg(channel__send__msg[4]),
		.send__rdy(channel__send__rdy[4])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__5(
		.clk(channel__clk[5]),
		.count(channel__count[5]),
		.reset(channel__reset[5]),
		.recv__en(channel__recv__en[5]),
		.recv__msg(channel__recv__msg[5]),
		.recv__rdy(channel__recv__rdy[5]),
		.send__en(channel__send__en[5]),
		.send__msg(channel__send__msg[5]),
		.send__rdy(channel__send__rdy[5])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__6(
		.clk(channel__clk[6]),
		.count(channel__count[6]),
		.reset(channel__reset[6]),
		.recv__en(channel__recv__en[6]),
		.recv__msg(channel__recv__msg[6]),
		.recv__rdy(channel__recv__rdy[6]),
		.send__en(channel__send__en[6]),
		.send__msg(channel__send__msg[6]),
		.send__rdy(channel__send__rdy[6])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__7(
		.clk(channel__clk[7]),
		.count(channel__count[7]),
		.reset(channel__reset[7]),
		.recv__en(channel__recv__en[7]),
		.recv__msg(channel__recv__msg[7]),
		.recv__rdy(channel__recv__rdy[7]),
		.send__en(channel__send__en[7]),
		.send__msg(channel__send__msg[7]),
		.send__rdy(channel__send__rdy[7])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__8(
		.clk(channel__clk[8]),
		.count(channel__count[8]),
		.reset(channel__reset[8]),
		.recv__en(channel__recv__en[8]),
		.recv__msg(channel__recv__msg[8]),
		.recv__rdy(channel__recv__rdy[8]),
		.send__en(channel__send__en[8]),
		.send__msg(channel__send__msg[8]),
		.send__rdy(channel__send__rdy[8])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__9(
		.clk(channel__clk[9]),
		.count(channel__count[9]),
		.reset(channel__reset[9]),
		.recv__en(channel__recv__en[9]),
		.recv__msg(channel__recv__msg[9]),
		.recv__rdy(channel__recv__rdy[9]),
		.send__en(channel__send__en[9]),
		.send__msg(channel__send__msg[9]),
		.send__rdy(channel__send__rdy[9])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__10(
		.clk(channel__clk[10]),
		.count(channel__count[10]),
		.reset(channel__reset[10]),
		.recv__en(channel__recv__en[10]),
		.recv__msg(channel__recv__msg[10]),
		.recv__rdy(channel__recv__rdy[10]),
		.send__en(channel__send__en[10]),
		.send__msg(channel__send__msg[10]),
		.send__rdy(channel__send__rdy[10])
	);
	ChannelRTL__DataType_CGRAData_32_1_1__latency_1 channel__11(
		.clk(channel__clk[11]),
		.count(channel__count[11]),
		.reset(channel__reset[11]),
		.recv__en(channel__recv__en[11]),
		.recv__msg(channel__recv__msg[11]),
		.recv__rdy(channel__recv__rdy[11]),
		.send__en(channel__send__en[11]),
		.send__msg(channel__send__msg[11]),
		.send__rdy(channel__send__rdy[11])
	);
	wire [0:0] const_queue__clk;
	wire [0:0] const_queue__reset;
	wire [0:0] const_queue__send_const__en;
	wire [33:0] const_queue__send_const__msg;
	wire [0:0] const_queue__send_const__rdy;
	ConstQueueRTL__2f4560623c67a554 const_queue(
		.clk(const_queue__clk),
		.reset(const_queue__reset),
		.send_const__en(const_queue__send_const__en),
		.send_const__msg(const_queue__send_const__msg),
		.send_const__rdy(const_queue__send_const__rdy)
	);
	wire [0:0] crossbar__clk;
	wire [0:0] crossbar__reset;
	wire [9:0] crossbar__recv_data__en;
	wire [339:0] crossbar__recv_data__msg;
	wire [9:0] crossbar__recv_data__rdy;
	reg [0:0] crossbar__recv_opt__en;
	reg [58:0] crossbar__recv_opt__msg;
	wire [0:0] crossbar__recv_opt__rdy;
	wire [11:0] crossbar__send_data__en;
	wire [407:0] crossbar__send_data__msg;
	wire [11:0] crossbar__send_data__rdy;
	wire [0:0] crossbar__send_predicate__en;
	wire [1:0] crossbar__send_predicate__msg;
	wire [0:0] crossbar__send_predicate__rdy;
	CrossbarRTL__874305e17dbe6b02 crossbar(
		.clk(crossbar__clk),
		.reset(crossbar__reset),
		.recv_data__en(crossbar__recv_data__en),
		.recv_data__msg(crossbar__recv_data__msg),
		.recv_data__rdy(crossbar__recv_data__rdy),
		.recv_opt__en(crossbar__recv_opt__en),
		.recv_opt__msg(crossbar__recv_opt__msg),
		.recv_opt__rdy(crossbar__recv_opt__rdy),
		.send_data__en(crossbar__send_data__en),
		.send_data__msg(crossbar__send_data__msg),
		.send_data__rdy(crossbar__send_data__rdy),
		.send_predicate__en(crossbar__send_predicate__en),
		.send_predicate__msg(crossbar__send_predicate__msg),
		.send_predicate__rdy(crossbar__send_predicate__rdy)
	);
	wire [0:0] ctrl_mem__clk;
	wire [0:0] ctrl_mem__reset;
	wire [0:0] ctrl_mem__recv_ctrl__en;
	wire [58:0] ctrl_mem__recv_ctrl__msg;
	wire [0:0] ctrl_mem__recv_ctrl__rdy;
	wire [0:0] ctrl_mem__recv_waddr__en;
	wire [2:0] ctrl_mem__recv_waddr__msg;
	wire [0:0] ctrl_mem__recv_waddr__rdy;
	wire [0:0] ctrl_mem__send_ctrl__en;
	wire [58:0] ctrl_mem__send_ctrl__msg;
	reg [0:0] ctrl_mem__send_ctrl__rdy;
	CtrlMemRTL__ebe00becbc7c6d54 ctrl_mem(
		.clk(ctrl_mem__clk),
		.reset(ctrl_mem__reset),
		.recv_ctrl__en(ctrl_mem__recv_ctrl__en),
		.recv_ctrl__msg(ctrl_mem__recv_ctrl__msg),
		.recv_ctrl__rdy(ctrl_mem__recv_ctrl__rdy),
		.recv_waddr__en(ctrl_mem__recv_waddr__en),
		.recv_waddr__msg(ctrl_mem__recv_waddr__msg),
		.recv_waddr__rdy(ctrl_mem__recv_waddr__rdy),
		.send_ctrl__en(ctrl_mem__send_ctrl__en),
		.send_ctrl__msg(ctrl_mem__send_ctrl__msg),
		.send_ctrl__rdy(ctrl_mem__send_ctrl__rdy)
	);
	wire [0:0] element__clk;
	wire [7:0] element__recv_in_count;
	wire [0:0] element__reset;
	wire [5:0] element__from_mem_rdata__en;
	wire [203:0] element__from_mem_rdata__msg;
	wire [5:0] element__from_mem_rdata__rdy;
	wire [0:0] element__recv_const__en;
	wire [33:0] element__recv_const__msg;
	wire [0:0] element__recv_const__rdy;
	wire [3:0] element__recv_in__en;
	wire [135:0] element__recv_in__msg;
	wire [3:0] element__recv_in__rdy;
	reg [0:0] element__recv_opt__en;
	reg [58:0] element__recv_opt__msg;
	wire [0:0] element__recv_opt__rdy;
	wire [0:0] element__recv_predicate__en;
	wire [1:0] element__recv_predicate__msg;
	wire [0:0] element__recv_predicate__rdy;
	wire [1:0] element__send_out__en;
	wire [67:0] element__send_out__msg;
	wire [1:0] element__send_out__rdy;
	wire [5:0] element__to_mem_raddr__en;
	wire [17:0] element__to_mem_raddr__msg;
	wire [5:0] element__to_mem_raddr__rdy;
	wire [5:0] element__to_mem_waddr__en;
	wire [17:0] element__to_mem_waddr__msg;
	wire [5:0] element__to_mem_waddr__rdy;
	wire [5:0] element__to_mem_wdata__en;
	wire [203:0] element__to_mem_wdata__msg;
	wire [5:0] element__to_mem_wdata__rdy;
	FlexibleFuRTL__7ccad8d3ed73c188 element(
		.clk(element__clk),
		.recv_in_count(element__recv_in_count),
		.reset(element__reset),
		.from_mem_rdata__en(element__from_mem_rdata__en),
		.from_mem_rdata__msg(element__from_mem_rdata__msg),
		.from_mem_rdata__rdy(element__from_mem_rdata__rdy),
		.recv_const__en(element__recv_const__en),
		.recv_const__msg(element__recv_const__msg),
		.recv_const__rdy(element__recv_const__rdy),
		.recv_in__en(element__recv_in__en),
		.recv_in__msg(element__recv_in__msg),
		.recv_in__rdy(element__recv_in__rdy),
		.recv_opt__en(element__recv_opt__en),
		.recv_opt__msg(element__recv_opt__msg),
		.recv_opt__rdy(element__recv_opt__rdy),
		.recv_predicate__en(element__recv_predicate__en),
		.recv_predicate__msg(element__recv_predicate__msg),
		.recv_predicate__rdy(element__recv_predicate__rdy),
		.send_out__en(element__send_out__en),
		.send_out__msg(element__send_out__msg),
		.send_out__rdy(element__send_out__rdy),
		.to_mem_raddr__en(element__to_mem_raddr__en),
		.to_mem_raddr__msg(element__to_mem_raddr__msg),
		.to_mem_raddr__rdy(element__to_mem_raddr__rdy),
		.to_mem_waddr__en(element__to_mem_waddr__en),
		.to_mem_waddr__msg(element__to_mem_waddr__msg),
		.to_mem_waddr__rdy(element__to_mem_waddr__rdy),
		.to_mem_wdata__en(element__to_mem_wdata__en),
		.to_mem_wdata__msg(element__to_mem_wdata__msg),
		.to_mem_wdata__rdy(element__to_mem_wdata__rdy)
	);
	wire [0:0] reg_predicate__clk;
	wire [0:0] reg_predicate__reset;
	wire [0:0] reg_predicate__recv__en;
	wire [1:0] reg_predicate__recv__msg;
	wire [0:0] reg_predicate__recv__rdy;
	wire [0:0] reg_predicate__send__en;
	wire [1:0] reg_predicate__send__msg;
	wire [0:0] reg_predicate__send__rdy;
	RegisterRTL__DataType_CGRAData_1_1__latency_1 reg_predicate(
		.clk(reg_predicate__clk),
		.reset(reg_predicate__reset),
		.recv__en(reg_predicate__recv__en),
		.recv__msg(reg_predicate__recv__msg),
		.recv__rdy(reg_predicate__recv__rdy),
		.send__en(reg_predicate__send__en),
		.send__msg(reg_predicate__send__msg),
		.send__rdy(reg_predicate__send__rdy)
	);
	always @(*) begin : update_opt
		element__recv_opt__msg = ctrl_mem__send_ctrl__msg;
		crossbar__recv_opt__msg = ctrl_mem__send_ctrl__msg;
		element__recv_opt__en = ctrl_mem__send_ctrl__en;
		crossbar__recv_opt__en = ctrl_mem__send_ctrl__en;
		ctrl_mem__send_ctrl__rdy = element__recv_opt__rdy && crossbar__recv_opt__rdy;
	end
	assign element__clk = clk;
	assign element__reset = reset;
	assign const_queue__clk = clk;
	assign const_queue__reset = reset;
	assign crossbar__clk = clk;
	assign crossbar__reset = reset;
	assign ctrl_mem__clk = clk;
	assign ctrl_mem__reset = reset;
	assign channel__clk[0] = clk;
	assign channel__reset[0] = reset;
	assign channel__clk[1] = clk;
	assign channel__reset[1] = reset;
	assign channel__clk[2] = clk;
	assign channel__reset[2] = reset;
	assign channel__clk[3] = clk;
	assign channel__reset[3] = reset;
	assign channel__clk[4] = clk;
	assign channel__reset[4] = reset;
	assign channel__clk[5] = clk;
	assign channel__reset[5] = reset;
	assign channel__clk[6] = clk;
	assign channel__reset[6] = reset;
	assign channel__clk[7] = clk;
	assign channel__reset[7] = reset;
	assign channel__clk[8] = clk;
	assign channel__reset[8] = reset;
	assign channel__clk[9] = clk;
	assign channel__reset[9] = reset;
	assign channel__clk[10] = clk;
	assign channel__reset[10] = reset;
	assign channel__clk[11] = clk;
	assign channel__reset[11] = reset;
	assign reg_predicate__clk = clk;
	assign reg_predicate__reset = reset;
	assign ctrl_mem__recv_waddr__en = recv_waddr__en;
	assign ctrl_mem__recv_waddr__msg = recv_waddr__msg;
	assign recv_waddr__rdy = ctrl_mem__recv_waddr__rdy;
	assign ctrl_mem__recv_ctrl__en = recv_wopt__en;
	assign ctrl_mem__recv_ctrl__msg = recv_wopt__msg;
	assign recv_wopt__rdy = ctrl_mem__recv_ctrl__rdy;
	assign element__recv_const__en = const_queue__send_const__en;
	assign element__recv_const__msg = const_queue__send_const__msg;
	assign const_queue__send_const__rdy = element__recv_const__rdy;
	assign element__to_mem_raddr__rdy[5+:1] = 1'd0;
	assign element__from_mem_rdata__en[5+:1] = 1'd0;
	assign element__from_mem_rdata__msg[170+:34] = 34'h000000000;
	assign element__to_mem_waddr__rdy[5+:1] = 1'd0;
	assign element__to_mem_wdata__rdy[5+:1] = 1'd0;
	assign element__to_mem_raddr__rdy[4+:1] = 1'd0;
	assign element__from_mem_rdata__en[4+:1] = 1'd0;
	assign element__from_mem_rdata__msg[136+:34] = 34'h000000000;
	assign element__to_mem_waddr__rdy[4+:1] = 1'd0;
	assign element__to_mem_wdata__rdy[4+:1] = 1'd0;
	assign element__to_mem_raddr__rdy[3+:1] = 1'd0;
	assign element__from_mem_rdata__en[3+:1] = 1'd0;
	assign element__from_mem_rdata__msg[102+:34] = 34'h000000000;
	assign element__to_mem_waddr__rdy[3+:1] = 1'd0;
	assign element__to_mem_wdata__rdy[3+:1] = 1'd0;
	assign element__to_mem_raddr__rdy[2+:1] = 1'd0;
	assign element__from_mem_rdata__en[2+:1] = 1'd0;
	assign element__from_mem_rdata__msg[68+:34] = 34'h000000000;
	assign element__to_mem_waddr__rdy[2+:1] = 1'd0;
	assign element__to_mem_wdata__rdy[2+:1] = 1'd0;
	assign element__to_mem_raddr__rdy[1+:1] = 1'd0;
	assign element__from_mem_rdata__en[1+:1] = 1'd0;
	assign element__from_mem_rdata__msg[34+:34] = 34'h000000000;
	assign element__to_mem_waddr__rdy[1+:1] = 1'd0;
	assign element__to_mem_wdata__rdy[1+:1] = 1'd0;
	assign to_mem_raddr__en = element__to_mem_raddr__en[0+:1];
	assign to_mem_raddr__msg = element__to_mem_raddr__msg[0+:3];
	assign element__to_mem_raddr__rdy[0+:1] = to_mem_raddr__rdy;
	assign element__from_mem_rdata__en[0+:1] = from_mem_rdata__en;
	assign element__from_mem_rdata__msg[0+:34] = from_mem_rdata__msg;
	assign from_mem_rdata__rdy = element__from_mem_rdata__rdy[0+:1];
	assign to_mem_waddr__en = element__to_mem_waddr__en[0+:1];
	assign to_mem_waddr__msg = element__to_mem_waddr__msg[0+:3];
	assign element__to_mem_waddr__rdy[0+:1] = to_mem_waddr__rdy;
	assign to_mem_wdata__en = element__to_mem_wdata__en[0+:1];
	assign to_mem_wdata__msg = element__to_mem_wdata__msg[0+:34];
	assign element__to_mem_wdata__rdy[0+:1] = to_mem_wdata__rdy;
	assign crossbar__recv_data__en[9+:1] = recv_data__en[7+:1];
	assign crossbar__recv_data__msg[306+:34] = recv_data__msg[238+:34];
	assign recv_data__rdy[7+:1] = crossbar__recv_data__rdy[9+:1];
	assign crossbar__recv_data__en[8+:1] = recv_data__en[6+:1];
	assign crossbar__recv_data__msg[272+:34] = recv_data__msg[204+:34];
	assign recv_data__rdy[6+:1] = crossbar__recv_data__rdy[8+:1];
	assign crossbar__recv_data__en[7+:1] = recv_data__en[5+:1];
	assign crossbar__recv_data__msg[238+:34] = recv_data__msg[170+:34];
	assign recv_data__rdy[5+:1] = crossbar__recv_data__rdy[7+:1];
	assign crossbar__recv_data__en[6+:1] = recv_data__en[4+:1];
	assign crossbar__recv_data__msg[204+:34] = recv_data__msg[136+:34];
	assign recv_data__rdy[4+:1] = crossbar__recv_data__rdy[6+:1];
	assign crossbar__recv_data__en[5+:1] = recv_data__en[3+:1];
	assign crossbar__recv_data__msg[170+:34] = recv_data__msg[102+:34];
	assign recv_data__rdy[3+:1] = crossbar__recv_data__rdy[5+:1];
	assign crossbar__recv_data__en[4+:1] = recv_data__en[2+:1];
	assign crossbar__recv_data__msg[136+:34] = recv_data__msg[68+:34];
	assign recv_data__rdy[2+:1] = crossbar__recv_data__rdy[4+:1];
	assign crossbar__recv_data__en[3+:1] = recv_data__en[1+:1];
	assign crossbar__recv_data__msg[102+:34] = recv_data__msg[34+:34];
	assign recv_data__rdy[1+:1] = crossbar__recv_data__rdy[3+:1];
	assign crossbar__recv_data__en[2+:1] = recv_data__en[0+:1];
	assign crossbar__recv_data__msg[68+:34] = recv_data__msg[0+:34];
	assign recv_data__rdy[0+:1] = crossbar__recv_data__rdy[2+:1];
	assign channel__recv__en[0] = crossbar__send_data__en[11+:1];
	assign channel__recv__msg[0] = crossbar__send_data__msg[374+:34];
	assign crossbar__send_data__rdy[11+:1] = channel__recv__rdy[0];
	assign channel__recv__en[1] = crossbar__send_data__en[10+:1];
	assign channel__recv__msg[1] = crossbar__send_data__msg[340+:34];
	assign crossbar__send_data__rdy[10+:1] = channel__recv__rdy[1];
	assign channel__recv__en[2] = crossbar__send_data__en[9+:1];
	assign channel__recv__msg[2] = crossbar__send_data__msg[306+:34];
	assign crossbar__send_data__rdy[9+:1] = channel__recv__rdy[2];
	assign channel__recv__en[3] = crossbar__send_data__en[8+:1];
	assign channel__recv__msg[3] = crossbar__send_data__msg[272+:34];
	assign crossbar__send_data__rdy[8+:1] = channel__recv__rdy[3];
	assign channel__recv__en[4] = crossbar__send_data__en[7+:1];
	assign channel__recv__msg[4] = crossbar__send_data__msg[238+:34];
	assign crossbar__send_data__rdy[7+:1] = channel__recv__rdy[4];
	assign channel__recv__en[5] = crossbar__send_data__en[6+:1];
	assign channel__recv__msg[5] = crossbar__send_data__msg[204+:34];
	assign crossbar__send_data__rdy[6+:1] = channel__recv__rdy[5];
	assign channel__recv__en[6] = crossbar__send_data__en[5+:1];
	assign channel__recv__msg[6] = crossbar__send_data__msg[170+:34];
	assign crossbar__send_data__rdy[5+:1] = channel__recv__rdy[6];
	assign channel__recv__en[7] = crossbar__send_data__en[4+:1];
	assign channel__recv__msg[7] = crossbar__send_data__msg[136+:34];
	assign crossbar__send_data__rdy[4+:1] = channel__recv__rdy[7];
	assign channel__recv__en[8] = crossbar__send_data__en[3+:1];
	assign channel__recv__msg[8] = crossbar__send_data__msg[102+:34];
	assign crossbar__send_data__rdy[3+:1] = channel__recv__rdy[8];
	assign channel__recv__en[9] = crossbar__send_data__en[2+:1];
	assign channel__recv__msg[9] = crossbar__send_data__msg[68+:34];
	assign crossbar__send_data__rdy[2+:1] = channel__recv__rdy[9];
	assign channel__recv__en[10] = crossbar__send_data__en[1+:1];
	assign channel__recv__msg[10] = crossbar__send_data__msg[34+:34];
	assign crossbar__send_data__rdy[1+:1] = channel__recv__rdy[10];
	assign channel__recv__en[11] = crossbar__send_data__en[0+:1];
	assign channel__recv__msg[11] = crossbar__send_data__msg[0+:34];
	assign crossbar__send_data__rdy[0+:1] = channel__recv__rdy[11];
	assign reg_predicate__recv__en = crossbar__send_predicate__en;
	assign reg_predicate__recv__msg = crossbar__send_predicate__msg;
	assign crossbar__send_predicate__rdy = reg_predicate__recv__rdy;
	assign element__recv_predicate__en = reg_predicate__send__en;
	assign element__recv_predicate__msg = reg_predicate__send__msg;
	assign reg_predicate__send__rdy = element__recv_predicate__rdy;
	assign send_data__en[7+:1] = channel__send__en[0];
	assign send_data__msg[238+:34] = channel__send__msg[0];
	assign channel__send__rdy[0] = send_data__rdy[7+:1];
	assign send_data__en[6+:1] = channel__send__en[1];
	assign send_data__msg[204+:34] = channel__send__msg[1];
	assign channel__send__rdy[1] = send_data__rdy[6+:1];
	assign send_data__en[5+:1] = channel__send__en[2];
	assign send_data__msg[170+:34] = channel__send__msg[2];
	assign channel__send__rdy[2] = send_data__rdy[5+:1];
	assign send_data__en[4+:1] = channel__send__en[3];
	assign send_data__msg[136+:34] = channel__send__msg[3];
	assign channel__send__rdy[3] = send_data__rdy[4+:1];
	assign send_data__en[3+:1] = channel__send__en[4];
	assign send_data__msg[102+:34] = channel__send__msg[4];
	assign channel__send__rdy[4] = send_data__rdy[3+:1];
	assign send_data__en[2+:1] = channel__send__en[5];
	assign send_data__msg[68+:34] = channel__send__msg[5];
	assign channel__send__rdy[5] = send_data__rdy[2+:1];
	assign send_data__en[1+:1] = channel__send__en[6];
	assign send_data__msg[34+:34] = channel__send__msg[6];
	assign channel__send__rdy[6] = send_data__rdy[1+:1];
	assign send_data__en[0+:1] = channel__send__en[7];
	assign send_data__msg[0+:34] = channel__send__msg[7];
	assign channel__send__rdy[7] = send_data__rdy[0+:1];
	assign element__recv_in__en[3+:1] = channel__send__en[8];
	assign element__recv_in__msg[102+:34] = channel__send__msg[8];
	assign channel__send__rdy[8] = element__recv_in__rdy[3+:1];
	assign element__recv_in_count[6+:2] = channel__count[8];
	assign element__recv_in__en[2+:1] = channel__send__en[9];
	assign element__recv_in__msg[68+:34] = channel__send__msg[9];
	assign channel__send__rdy[9] = element__recv_in__rdy[2+:1];
	assign element__recv_in_count[4+:2] = channel__count[9];
	assign element__recv_in__en[1+:1] = channel__send__en[10];
	assign element__recv_in__msg[34+:34] = channel__send__msg[10];
	assign channel__send__rdy[10] = element__recv_in__rdy[1+:1];
	assign element__recv_in_count[2+:2] = channel__count[10];
	assign element__recv_in__en[0+:1] = channel__send__en[11];
	assign element__recv_in__msg[0+:34] = channel__send__msg[11];
	assign channel__send__rdy[11] = element__recv_in__rdy[0+:1];
	assign element__recv_in_count[0+:2] = channel__count[11];
	assign crossbar__recv_data__en[1+:1] = element__send_out__en[1+:1];
	assign crossbar__recv_data__msg[34+:34] = element__send_out__msg[34+:34];
	assign element__send_out__rdy[1+:1] = crossbar__recv_data__rdy[1+:1];
	assign crossbar__recv_data__en[0+:1] = element__send_out__en[0+:1];
	assign crossbar__recv_data__msg[0+:34] = element__send_out__msg[0+:34];
	assign element__send_out__rdy[0+:1] = crossbar__recv_data__rdy[0+:1];
endmodule
module CGRAKingMeshRTL__99cbcfeeb0999932 (
	clk,
	reset,
	recv_waddr__en,
	recv_waddr__msg,
	recv_waddr__rdy,
	recv_wopt__en,
	recv_wopt__msg,
	recv_wopt__rdy
);
	input wire [0:0] clk;
	input wire [0:0] reset;
	input wire [3:0] recv_waddr__en;
	input wire [11:0] recv_waddr__msg;
	output wire [3:0] recv_waddr__rdy;
	input wire [3:0] recv_wopt__en;
	input wire [235:0] recv_wopt__msg;
	output wire [3:0] recv_wopt__rdy;
	wire [0:0] data_mem__clk;
	wire [0:0] data_mem__reset;
	wire [1:0] data_mem__recv_raddr__en;
	wire [5:0] data_mem__recv_raddr__msg;
	wire [1:0] data_mem__recv_raddr__rdy;
	wire [1:0] data_mem__recv_waddr__en;
	wire [5:0] data_mem__recv_waddr__msg;
	wire [1:0] data_mem__recv_waddr__rdy;
	wire [1:0] data_mem__recv_wdata__en;
	wire [67:0] data_mem__recv_wdata__msg;
	wire [1:0] data_mem__recv_wdata__rdy;
	wire [1:0] data_mem__send_rdata__en;
	wire [67:0] data_mem__send_rdata__msg;
	wire [1:0] data_mem__send_rdata__rdy;
	DataMemRTL__8bb42015d7ad3eea data_mem(
		.clk(data_mem__clk),
		.reset(data_mem__reset),
		.recv_raddr__en(data_mem__recv_raddr__en),
		.recv_raddr__msg(data_mem__recv_raddr__msg),
		.recv_raddr__rdy(data_mem__recv_raddr__rdy),
		.recv_waddr__en(data_mem__recv_waddr__en),
		.recv_waddr__msg(data_mem__recv_waddr__msg),
		.recv_waddr__rdy(data_mem__recv_waddr__rdy),
		.recv_wdata__en(data_mem__recv_wdata__en),
		.recv_wdata__msg(data_mem__recv_wdata__msg),
		.recv_wdata__rdy(data_mem__recv_wdata__rdy),
		.send_rdata__en(data_mem__send_rdata__en),
		.send_rdata__msg(data_mem__send_rdata__msg),
		.send_rdata__rdy(data_mem__send_rdata__rdy)
	);
	wire [0:0] tile__clk [0:3];
	wire [0:0] tile__reset [0:3];
	wire [0:0] tile__from_mem_rdata__en [0:3];
	wire [33:0] tile__from_mem_rdata__msg [0:3];
	wire [0:0] tile__from_mem_rdata__rdy [0:3];
	wire [7:0] tile__recv_data__en [0:3];
	wire [271:0] tile__recv_data__msg [0:3];
	wire [7:0] tile__recv_data__rdy [0:3];
	wire [0:0] tile__recv_waddr__en [0:3];
	wire [2:0] tile__recv_waddr__msg [0:3];
	wire [0:0] tile__recv_waddr__rdy [0:3];
	wire [0:0] tile__recv_wopt__en [0:3];
	wire [58:0] tile__recv_wopt__msg [0:3];
	wire [0:0] tile__recv_wopt__rdy [0:3];
	wire [7:0] tile__send_data__en [0:3];
	wire [271:0] tile__send_data__msg [0:3];
	wire [7:0] tile__send_data__rdy [0:3];
	wire [0:0] tile__to_mem_raddr__en [0:3];
	wire [2:0] tile__to_mem_raddr__msg [0:3];
	wire [0:0] tile__to_mem_raddr__rdy [0:3];
	wire [0:0] tile__to_mem_waddr__en [0:3];
	wire [2:0] tile__to_mem_waddr__msg [0:3];
	wire [0:0] tile__to_mem_waddr__rdy [0:3];
	wire [0:0] tile__to_mem_wdata__en [0:3];
	wire [33:0] tile__to_mem_wdata__msg [0:3];
	wire [0:0] tile__to_mem_wdata__rdy [0:3];
	TileRTL__40947ac956b390e0 tile__0(
		.clk(tile__clk[0]),
		.reset(tile__reset[0]),
		.from_mem_rdata__en(tile__from_mem_rdata__en[0]),
		.from_mem_rdata__msg(tile__from_mem_rdata__msg[0]),
		.from_mem_rdata__rdy(tile__from_mem_rdata__rdy[0]),
		.recv_data__en(tile__recv_data__en[0]),
		.recv_data__msg(tile__recv_data__msg[0]),
		.recv_data__rdy(tile__recv_data__rdy[0]),
		.recv_waddr__en(tile__recv_waddr__en[0]),
		.recv_waddr__msg(tile__recv_waddr__msg[0]),
		.recv_waddr__rdy(tile__recv_waddr__rdy[0]),
		.recv_wopt__en(tile__recv_wopt__en[0]),
		.recv_wopt__msg(tile__recv_wopt__msg[0]),
		.recv_wopt__rdy(tile__recv_wopt__rdy[0]),
		.send_data__en(tile__send_data__en[0]),
		.send_data__msg(tile__send_data__msg[0]),
		.send_data__rdy(tile__send_data__rdy[0]),
		.to_mem_raddr__en(tile__to_mem_raddr__en[0]),
		.to_mem_raddr__msg(tile__to_mem_raddr__msg[0]),
		.to_mem_raddr__rdy(tile__to_mem_raddr__rdy[0]),
		.to_mem_waddr__en(tile__to_mem_waddr__en[0]),
		.to_mem_waddr__msg(tile__to_mem_waddr__msg[0]),
		.to_mem_waddr__rdy(tile__to_mem_waddr__rdy[0]),
		.to_mem_wdata__en(tile__to_mem_wdata__en[0]),
		.to_mem_wdata__msg(tile__to_mem_wdata__msg[0]),
		.to_mem_wdata__rdy(tile__to_mem_wdata__rdy[0])
	);
	TileRTL__40947ac956b390e0 tile__1(
		.clk(tile__clk[1]),
		.reset(tile__reset[1]),
		.from_mem_rdata__en(tile__from_mem_rdata__en[1]),
		.from_mem_rdata__msg(tile__from_mem_rdata__msg[1]),
		.from_mem_rdata__rdy(tile__from_mem_rdata__rdy[1]),
		.recv_data__en(tile__recv_data__en[1]),
		.recv_data__msg(tile__recv_data__msg[1]),
		.recv_data__rdy(tile__recv_data__rdy[1]),
		.recv_waddr__en(tile__recv_waddr__en[1]),
		.recv_waddr__msg(tile__recv_waddr__msg[1]),
		.recv_waddr__rdy(tile__recv_waddr__rdy[1]),
		.recv_wopt__en(tile__recv_wopt__en[1]),
		.recv_wopt__msg(tile__recv_wopt__msg[1]),
		.recv_wopt__rdy(tile__recv_wopt__rdy[1]),
		.send_data__en(tile__send_data__en[1]),
		.send_data__msg(tile__send_data__msg[1]),
		.send_data__rdy(tile__send_data__rdy[1]),
		.to_mem_raddr__en(tile__to_mem_raddr__en[1]),
		.to_mem_raddr__msg(tile__to_mem_raddr__msg[1]),
		.to_mem_raddr__rdy(tile__to_mem_raddr__rdy[1]),
		.to_mem_waddr__en(tile__to_mem_waddr__en[1]),
		.to_mem_waddr__msg(tile__to_mem_waddr__msg[1]),
		.to_mem_waddr__rdy(tile__to_mem_waddr__rdy[1]),
		.to_mem_wdata__en(tile__to_mem_wdata__en[1]),
		.to_mem_wdata__msg(tile__to_mem_wdata__msg[1]),
		.to_mem_wdata__rdy(tile__to_mem_wdata__rdy[1])
	);
	TileRTL__40947ac956b390e0 tile__2(
		.clk(tile__clk[2]),
		.reset(tile__reset[2]),
		.from_mem_rdata__en(tile__from_mem_rdata__en[2]),
		.from_mem_rdata__msg(tile__from_mem_rdata__msg[2]),
		.from_mem_rdata__rdy(tile__from_mem_rdata__rdy[2]),
		.recv_data__en(tile__recv_data__en[2]),
		.recv_data__msg(tile__recv_data__msg[2]),
		.recv_data__rdy(tile__recv_data__rdy[2]),
		.recv_waddr__en(tile__recv_waddr__en[2]),
		.recv_waddr__msg(tile__recv_waddr__msg[2]),
		.recv_waddr__rdy(tile__recv_waddr__rdy[2]),
		.recv_wopt__en(tile__recv_wopt__en[2]),
		.recv_wopt__msg(tile__recv_wopt__msg[2]),
		.recv_wopt__rdy(tile__recv_wopt__rdy[2]),
		.send_data__en(tile__send_data__en[2]),
		.send_data__msg(tile__send_data__msg[2]),
		.send_data__rdy(tile__send_data__rdy[2]),
		.to_mem_raddr__en(tile__to_mem_raddr__en[2]),
		.to_mem_raddr__msg(tile__to_mem_raddr__msg[2]),
		.to_mem_raddr__rdy(tile__to_mem_raddr__rdy[2]),
		.to_mem_waddr__en(tile__to_mem_waddr__en[2]),
		.to_mem_waddr__msg(tile__to_mem_waddr__msg[2]),
		.to_mem_waddr__rdy(tile__to_mem_waddr__rdy[2]),
		.to_mem_wdata__en(tile__to_mem_wdata__en[2]),
		.to_mem_wdata__msg(tile__to_mem_wdata__msg[2]),
		.to_mem_wdata__rdy(tile__to_mem_wdata__rdy[2])
	);
	TileRTL__40947ac956b390e0 tile__3(
		.clk(tile__clk[3]),
		.reset(tile__reset[3]),
		.from_mem_rdata__en(tile__from_mem_rdata__en[3]),
		.from_mem_rdata__msg(tile__from_mem_rdata__msg[3]),
		.from_mem_rdata__rdy(tile__from_mem_rdata__rdy[3]),
		.recv_data__en(tile__recv_data__en[3]),
		.recv_data__msg(tile__recv_data__msg[3]),
		.recv_data__rdy(tile__recv_data__rdy[3]),
		.recv_waddr__en(tile__recv_waddr__en[3]),
		.recv_waddr__msg(tile__recv_waddr__msg[3]),
		.recv_waddr__rdy(tile__recv_waddr__rdy[3]),
		.recv_wopt__en(tile__recv_wopt__en[3]),
		.recv_wopt__msg(tile__recv_wopt__msg[3]),
		.recv_wopt__rdy(tile__recv_wopt__rdy[3]),
		.send_data__en(tile__send_data__en[3]),
		.send_data__msg(tile__send_data__msg[3]),
		.send_data__rdy(tile__send_data__rdy[3]),
		.to_mem_raddr__en(tile__to_mem_raddr__en[3]),
		.to_mem_raddr__msg(tile__to_mem_raddr__msg[3]),
		.to_mem_raddr__rdy(tile__to_mem_raddr__rdy[3]),
		.to_mem_waddr__en(tile__to_mem_waddr__en[3]),
		.to_mem_waddr__msg(tile__to_mem_waddr__msg[3]),
		.to_mem_waddr__rdy(tile__to_mem_waddr__rdy[3]),
		.to_mem_wdata__en(tile__to_mem_wdata__en[3]),
		.to_mem_wdata__msg(tile__to_mem_wdata__msg[3]),
		.to_mem_wdata__rdy(tile__to_mem_wdata__rdy[3])
	);
	assign tile__clk[0] = clk;
	assign tile__reset[0] = reset;
	assign tile__clk[1] = clk;
	assign tile__reset[1] = reset;
	assign tile__clk[2] = clk;
	assign tile__reset[2] = reset;
	assign tile__clk[3] = clk;
	assign tile__reset[3] = reset;
	assign data_mem__clk = clk;
	assign data_mem__reset = reset;
	assign tile__recv_waddr__en[0] = recv_waddr__en[3+:1];
	assign tile__recv_waddr__msg[0] = recv_waddr__msg[9+:3];
	assign recv_waddr__rdy[3+:1] = tile__recv_waddr__rdy[0];
	assign tile__recv_wopt__en[0] = recv_wopt__en[3+:1];
	assign tile__recv_wopt__msg[0] = recv_wopt__msg[177+:59];
	assign recv_wopt__rdy[3+:1] = tile__recv_wopt__rdy[0];
	assign tile__recv_data__en[2][6+:1] = tile__send_data__en[0][7+:1];
	assign tile__recv_data__msg[2][204+:34] = tile__send_data__msg[0][238+:34];
	assign tile__send_data__rdy[0][7+:1] = tile__recv_data__rdy[2][6+:1];
	assign tile__recv_data__en[1][5+:1] = tile__send_data__en[0][4+:1];
	assign tile__recv_data__msg[1][170+:34] = tile__send_data__msg[0][136+:34];
	assign tile__send_data__rdy[0][4+:1] = tile__recv_data__rdy[1][5+:1];
	assign tile__recv_data__en[3][0+:1] = tile__send_data__en[0][2+:1];
	assign tile__recv_data__msg[3][0+:34] = tile__send_data__msg[0][68+:34];
	assign tile__send_data__rdy[0][2+:1] = tile__recv_data__rdy[3][0+:1];
	assign tile__recv_data__en[0][2+:1] = tile__send_data__en[3][0+:1];
	assign tile__recv_data__msg[0][68+:34] = tile__send_data__msg[3][0+:34];
	assign tile__send_data__rdy[3][0+:1] = tile__recv_data__rdy[0][2+:1];
	assign tile__send_data__rdy[0][6+:1] = 1'd0;
	assign tile__recv_data__en[0][6+:1] = 1'd0;
	assign tile__recv_data__msg[0][204+:34] = 34'h000000000;
	assign tile__send_data__rdy[0][0+:1] = 1'd0;
	assign tile__recv_data__en[0][0+:1] = 1'd0;
	assign tile__recv_data__msg[0][0+:34] = 34'h000000000;
	assign tile__send_data__rdy[0][1+:1] = 1'd0;
	assign tile__recv_data__en[0][1+:1] = 1'd0;
	assign tile__recv_data__msg[0][34+:34] = 34'h000000000;
	assign tile__send_data__rdy[0][3+:1] = 1'd0;
	assign tile__recv_data__en[0][3+:1] = 1'd0;
	assign tile__recv_data__msg[0][102+:34] = 34'h000000000;
	assign tile__send_data__rdy[0][5+:1] = 1'd0;
	assign tile__recv_data__en[0][5+:1] = 1'd0;
	assign tile__recv_data__msg[0][170+:34] = 34'h000000000;
	assign data_mem__recv_raddr__en[1+:1] = tile__to_mem_raddr__en[0];
	assign data_mem__recv_raddr__msg[3+:3] = tile__to_mem_raddr__msg[0];
	assign tile__to_mem_raddr__rdy[0] = data_mem__recv_raddr__rdy[1+:1];
	assign tile__from_mem_rdata__en[0] = data_mem__send_rdata__en[1+:1];
	assign tile__from_mem_rdata__msg[0] = data_mem__send_rdata__msg[34+:34];
	assign data_mem__send_rdata__rdy[1+:1] = tile__from_mem_rdata__rdy[0];
	assign data_mem__recv_waddr__en[1+:1] = tile__to_mem_waddr__en[0];
	assign data_mem__recv_waddr__msg[3+:3] = tile__to_mem_waddr__msg[0];
	assign tile__to_mem_waddr__rdy[0] = data_mem__recv_waddr__rdy[1+:1];
	assign data_mem__recv_wdata__en[1+:1] = tile__to_mem_wdata__en[0];
	assign data_mem__recv_wdata__msg[34+:34] = tile__to_mem_wdata__msg[0];
	assign tile__to_mem_wdata__rdy[0] = data_mem__recv_wdata__rdy[1+:1];
	assign tile__recv_waddr__en[1] = recv_waddr__en[2+:1];
	assign tile__recv_waddr__msg[1] = recv_waddr__msg[6+:3];
	assign recv_waddr__rdy[2+:1] = tile__recv_waddr__rdy[1];
	assign tile__recv_wopt__en[1] = recv_wopt__en[2+:1];
	assign tile__recv_wopt__msg[1] = recv_wopt__msg[118+:59];
	assign recv_wopt__rdy[2+:1] = tile__recv_wopt__rdy[1];
	assign tile__recv_data__en[3][6+:1] = tile__send_data__en[1][7+:1];
	assign tile__recv_data__msg[3][204+:34] = tile__send_data__msg[1][238+:34];
	assign tile__send_data__rdy[1][7+:1] = tile__recv_data__rdy[3][6+:1];
	assign tile__recv_data__en[0][4+:1] = tile__send_data__en[1][5+:1];
	assign tile__recv_data__msg[0][136+:34] = tile__send_data__msg[1][170+:34];
	assign tile__send_data__rdy[1][5+:1] = tile__recv_data__rdy[0][4+:1];
	assign tile__recv_data__en[2][1+:1] = tile__send_data__en[1][3+:1];
	assign tile__recv_data__msg[2][34+:34] = tile__send_data__msg[1][102+:34];
	assign tile__send_data__rdy[1][3+:1] = tile__recv_data__rdy[2][1+:1];
	assign tile__recv_data__en[1][3+:1] = tile__send_data__en[2][1+:1];
	assign tile__recv_data__msg[1][102+:34] = tile__send_data__msg[2][34+:34];
	assign tile__send_data__rdy[2][1+:1] = tile__recv_data__rdy[1][3+:1];
	assign tile__send_data__rdy[1][6+:1] = 1'd0;
	assign tile__recv_data__en[1][6+:1] = 1'd0;
	assign tile__recv_data__msg[1][204+:34] = 34'h000000000;
	assign tile__send_data__rdy[1][0+:1] = 1'd0;
	assign tile__recv_data__en[1][0+:1] = 1'd0;
	assign tile__recv_data__msg[1][0+:34] = 34'h000000000;
	assign tile__send_data__rdy[1][1+:1] = 1'd0;
	assign tile__recv_data__en[1][1+:1] = 1'd0;
	assign tile__recv_data__msg[1][34+:34] = 34'h000000000;
	assign tile__send_data__rdy[1][2+:1] = 1'd0;
	assign tile__recv_data__en[1][2+:1] = 1'd0;
	assign tile__recv_data__msg[1][68+:34] = 34'h000000000;
	assign tile__send_data__rdy[1][4+:1] = 1'd0;
	assign tile__recv_data__en[1][4+:1] = 1'd0;
	assign tile__recv_data__msg[1][136+:34] = 34'h000000000;
	assign tile__to_mem_raddr__rdy[1] = 1'd0;
	assign tile__from_mem_rdata__en[1] = 1'd0;
	assign tile__from_mem_rdata__msg[1] = 34'h000000000;
	assign tile__to_mem_waddr__rdy[1] = 1'd0;
	assign tile__to_mem_wdata__rdy[1] = 1'd0;
	assign tile__recv_waddr__en[2] = recv_waddr__en[1+:1];
	assign tile__recv_waddr__msg[2] = recv_waddr__msg[3+:3];
	assign recv_waddr__rdy[1+:1] = tile__recv_waddr__rdy[2];
	assign tile__recv_wopt__en[2] = recv_wopt__en[1+:1];
	assign tile__recv_wopt__msg[2] = recv_wopt__msg[59+:59];
	assign recv_wopt__rdy[1+:1] = tile__recv_wopt__rdy[2];
	assign tile__recv_data__en[0][7+:1] = tile__send_data__en[2][6+:1];
	assign tile__recv_data__msg[0][238+:34] = tile__send_data__msg[2][204+:34];
	assign tile__send_data__rdy[2][6+:1] = tile__recv_data__rdy[0][7+:1];
	assign tile__recv_data__en[3][5+:1] = tile__send_data__en[2][4+:1];
	assign tile__recv_data__msg[3][170+:34] = tile__send_data__msg[2][136+:34];
	assign tile__send_data__rdy[2][4+:1] = tile__recv_data__rdy[3][5+:1];
	assign tile__send_data__rdy[2][7+:1] = 1'd0;
	assign tile__recv_data__en[2][7+:1] = 1'd0;
	assign tile__recv_data__msg[2][238+:34] = 34'h000000000;
	assign tile__send_data__rdy[2][3+:1] = 1'd0;
	assign tile__recv_data__en[2][3+:1] = 1'd0;
	assign tile__recv_data__msg[2][102+:34] = 34'h000000000;
	assign tile__send_data__rdy[2][2+:1] = 1'd0;
	assign tile__recv_data__en[2][2+:1] = 1'd0;
	assign tile__recv_data__msg[2][68+:34] = 34'h000000000;
	assign tile__send_data__rdy[2][0+:1] = 1'd0;
	assign tile__recv_data__en[2][0+:1] = 1'd0;
	assign tile__recv_data__msg[2][0+:34] = 34'h000000000;
	assign tile__send_data__rdy[2][5+:1] = 1'd0;
	assign tile__recv_data__en[2][5+:1] = 1'd0;
	assign tile__recv_data__msg[2][170+:34] = 34'h000000000;
	assign data_mem__recv_raddr__en[0+:1] = tile__to_mem_raddr__en[2];
	assign data_mem__recv_raddr__msg[0+:3] = tile__to_mem_raddr__msg[2];
	assign tile__to_mem_raddr__rdy[2] = data_mem__recv_raddr__rdy[0+:1];
	assign tile__from_mem_rdata__en[2] = data_mem__send_rdata__en[0+:1];
	assign tile__from_mem_rdata__msg[2] = data_mem__send_rdata__msg[0+:34];
	assign data_mem__send_rdata__rdy[0+:1] = tile__from_mem_rdata__rdy[2];
	assign data_mem__recv_waddr__en[0+:1] = tile__to_mem_waddr__en[2];
	assign data_mem__recv_waddr__msg[0+:3] = tile__to_mem_waddr__msg[2];
	assign tile__to_mem_waddr__rdy[2] = data_mem__recv_waddr__rdy[0+:1];
	assign data_mem__recv_wdata__en[0+:1] = tile__to_mem_wdata__en[2];
	assign data_mem__recv_wdata__msg[0+:34] = tile__to_mem_wdata__msg[2];
	assign tile__to_mem_wdata__rdy[2] = data_mem__recv_wdata__rdy[0+:1];
	assign tile__recv_waddr__en[3] = recv_waddr__en[0+:1];
	assign tile__recv_waddr__msg[3] = recv_waddr__msg[0+:3];
	assign recv_waddr__rdy[0+:1] = tile__recv_waddr__rdy[3];
	assign tile__recv_wopt__en[3] = recv_wopt__en[0+:1];
	assign tile__recv_wopt__msg[3] = recv_wopt__msg[0+:59];
	assign recv_wopt__rdy[0+:1] = tile__recv_wopt__rdy[3];
	assign tile__recv_data__en[1][7+:1] = tile__send_data__en[3][6+:1];
	assign tile__recv_data__msg[1][238+:34] = tile__send_data__msg[3][204+:34];
	assign tile__send_data__rdy[3][6+:1] = tile__recv_data__rdy[1][7+:1];
	assign tile__recv_data__en[2][4+:1] = tile__send_data__en[3][5+:1];
	assign tile__recv_data__msg[2][136+:34] = tile__send_data__msg[3][170+:34];
	assign tile__send_data__rdy[3][5+:1] = tile__recv_data__rdy[2][4+:1];
	assign tile__send_data__rdy[3][7+:1] = 1'd0;
	assign tile__recv_data__en[3][7+:1] = 1'd0;
	assign tile__recv_data__msg[3][238+:34] = 34'h000000000;
	assign tile__send_data__rdy[3][3+:1] = 1'd0;
	assign tile__recv_data__en[3][3+:1] = 1'd0;
	assign tile__recv_data__msg[3][102+:34] = 34'h000000000;
	assign tile__send_data__rdy[3][2+:1] = 1'd0;
	assign tile__recv_data__en[3][2+:1] = 1'd0;
	assign tile__recv_data__msg[3][68+:34] = 34'h000000000;
	assign tile__send_data__rdy[3][1+:1] = 1'd0;
	assign tile__recv_data__en[3][1+:1] = 1'd0;
	assign tile__recv_data__msg[3][34+:34] = 34'h000000000;
	assign tile__send_data__rdy[3][4+:1] = 1'd0;
	assign tile__recv_data__en[3][4+:1] = 1'd0;
	assign tile__recv_data__msg[3][136+:34] = 34'h000000000;
	assign tile__to_mem_raddr__rdy[3] = 1'd0;
	assign tile__from_mem_rdata__en[3] = 1'd0;
	assign tile__from_mem_rdata__msg[3] = 34'h000000000;
	assign tile__to_mem_waddr__rdy[3] = 1'd0;
	assign tile__to_mem_wdata__rdy[3] = 1'd0;
endmodule
