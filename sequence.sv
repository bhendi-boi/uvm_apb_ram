class write_read_seq extends uvm_sequence;
    `uvm_object_utils(write_read_seq)

    transaction tr;
    int i;

    function new(string name = "write_read_sequence");
        super.new(name);
        `uvm_info("Write Read sequence", "Constructed write_read_sequence",
                  UVM_HIGH)
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        i  = 0;
        for (i = 0; i < 32; i++) begin
            // write transaction 
            start_item(tr);
            tr.randomize() with {
                op == 2'b01;
                presetn == 1;
                paddr == i;
                pwrite == 1;
            };
            finish_item(tr);
            // read transaction 
            start_item(tr);
            tr.randomize() with {
                op == 2'b00;
                presetn == 1;
                paddr == i;
                pwrite == 0;
            };
            finish_item(tr);
        end
    endtask

endclass


class reset_seq extends uvm_sequence;
    `uvm_object_utils(reset_seq)

    transaction tr;

    function new(string name = "reset_sequence");
        super.new(name);
        `uvm_info("Reset sequence", "Constructed reset sequence", UVM_HIGH)
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        start_item(tr);
        tr.randomize() with {
            op == 2'b10;
            presetn == 1'b0;
            paddr == 1'b0;
            pwrite == 1'b0;
            pwdata == 1'b0;
        };
        finish_item(tr);
    endtask

endclass


class error_seq extends uvm_sequence;
    `uvm_object_utils(error_seq)

    transaction tr;

    function new(string name = "error_sequence");
        super.new(name);
        `uvm_info("Error sequence", "Constructed error sequence", UVM_HIGH)
    endfunction

    task body();
        tr = transaction::type_id::create("tr");
        start_item(tr);
        tr.randomize() with {
            op == 2'b01;
            presetn == 1'b1;
            paddr > 32;
            pwrite == 1'b1;
            pwdata == 1'b0;
        };
        finish_item(tr);

        // read
        start_item(tr);
        tr.randomize() with {
            op == 2'b00;
            presetn == 1'b1;
            paddr > 32;
            pwrite == 1'b0;
            pwdata == 1'b0;
        };
        finish_item(tr);
    endtask
endclass
