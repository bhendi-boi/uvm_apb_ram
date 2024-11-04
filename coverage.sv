class cvg extends uvm_subscriber #(transaction);
    `uvm_component_utils(cvg)

    uvm_analysis_imp #(transaction, cvg) coverage_port;

    transaction tr;
    covergroup func;
        option.per_instance = 1;
        option.auto_bin_max = 8;
        addr: coverpoint tr.addr {
            bins valid[] = {[0 : 31]}; bins invalid = {[32 : $]};
        }
        din: coverpoint tr.din;
        dout: coverpoint tr.dout;
        r_w: coverpoint tr.wr {bins read = {0}; bins write = {1};}
        error: coverpoint tr.err;
        read_all: cross r_w, addr{ignore_bins write = binsof (r_w.write);}
        write_all: cross r_w, addr{ignore_bins read = binsof (r_w.read);}
    endgroup



    function new(string name = "cvg", uvm_component parent);
        super.new(name, parent);
        func = new();
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr = transaction::type_id::create("tr");
        coverage_port = new("coverage_port", this);
    endfunction

    function void write(transaction t);
        tr = t;
        func.sample();
    endfunction

endclass
