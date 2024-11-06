class drv extends uvm_driver #(transaction);
    `uvm_component_utils(drv)

    virtual apb_if vif;
    transaction tr;

    function new(string name = "driver", uvm_component parent);

        super.new(name, parent);
        `uvm_info("Driver", "Constructed driver", UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);
        `uvm_info("Driver", "Build phase driver", UVM_HIGH)

        if (!(uvm_config_db#(virtual apb_if)::get(this, "*", "vif", vif))) begin
            `uvm_fatal("Driver", "Driver couldn't get vif")
        end
    endfunction

    task run_phase(uvm_phase phase);

        super.run_phase(phase);
        `uvm_info("Driver", "Run phase driver", UVM_HIGH)
        tr = transaction::type_id::create("tr");

        forever begin
            seq_item_port.get_next_item(tr);
            drive(tr);
            `uvm_info("Driver", "Drove a transaction", UVM_NONE)
            seq_item_port.item_done();
        end
    endtask

    task drive(transaction tr);
        @(posedge vif.pclk);
        if (tr.op == rst) begin
            vif.presetn <= 1'b0;
            vif.paddr <= 32'hx;
            vif.pwrite <= 32'hx;
            vif.penable <= 1'b0;
            vif.psel <= 1'b0;
        end else begin
            @(posedge vif.pclk);
            vif.presetn <= 1'b1;
            @(posedge vif.pclk);
            vif.psel   <= 1'b1;
            vif.paddr  <= tr.paddr;
            vif.pwrite <= tr.pwrite;
            vif.pwdata <= tr.pwdata;
            @(posedge vif.pclk);
            vif.penable <= 1'b1;
            @(negedge vif.pready);
            vif.penable <= 1'b0;
            @(posedge vif.pclk);
        end
    endtask
endclass
