interface apb_if (
    input logic pclk
);
  logic        presetn;
  logic [31:0] paddr;
  logic        pwrite;
  logic [31:0] pwdata;
  logic        penable;
  logic        psel;
  logic [31:0] prdata;
  logic        pslverr;
  logic        pready;
endinterface : apb_if
