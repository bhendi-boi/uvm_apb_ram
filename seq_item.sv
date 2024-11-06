class transaction extends uvm_sequence_item;
    `uvm_object_utils(transaction)

    // inputs
    rand oper_mode op;
    rand logic presetn, pwrite;
    logic psel, penable;
    rand logic [31:0] pwdata, paddr;

    // outputs
    logic pslverr, pready;
    logic [31:0] prdata;

    function new(string name = "transaction");
        super.new(name);
    endfunction

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field_int("Write/Read", pwrite, 1, UVM_HEX);
        printer.print_field_int("Address", paddr, 32, UVM_HEX);
        printer.print_field_int("Data In", pwdata, 32, UVM_HEX);
        printer.print_field_int("Data Out", prdata, 32, UVM_HEX);
        printer.print_field_int("Error", pslverr, 1, UVM_HEX);
    endfunction

endclass
