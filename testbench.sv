import uvm_pkg::*;
typedef enum bit [1:0] {
    readd = 0,
    writed = 1,
    rst = 2
} oper_mode;

`include "uvm_macros.svh"
`include "interface.sv"
`include "seq_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "write_read.sv"

module tb ();

    logic clk;

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    apb_if vif (.pclk(clk));

    apb_ram dut (
        .presetn(vif.presetn),
        .pclk(vif.pclk),
        .psel(vif.psel),
        .penable(vif.penable),
        .pwrite(vif.pwrite),
        .paddr(vif.paddr),
        .pwdata(vif.pwdata),
        .prdata(vif.prdata),
        .pready(vif.pready),
        .pslverr(vif.pslverr)
    );

    initial begin
        uvm_config_db#(virtual apb_if)::set(null, "*", "vif", vif);
        run_test("write_read_test");
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

endmodule
