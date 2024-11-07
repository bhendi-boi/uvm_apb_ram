class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    env environment;
    reset_seq reset_sequence;

    function new(string name = "base_test", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Base test", "Build phase base test", UVM_HIGH)
        environment = env::type_id::create("env", this);
    endfunction


endclass
