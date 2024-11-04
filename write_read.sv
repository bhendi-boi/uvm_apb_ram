class write_read_test extends uvm_test;
    `uvm_component_utils(write_read_test)

    env environment;
    write_read_seq write_read_sequence;
    reset_seq reset_sequence;

    function new(string name = "write_read_test", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Write Read Test", "Build phase write read test", UVM_HIGH)
        environment = env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);

        super.run_phase(phase);
        phase.raise_objection(this);

        write_read_sequence = write_read_seq::type_id::create("write_read");
        reset_sequence = reset_seq::type_id::create("reset");
        reset_sequence.start(environment.agent.sequencer);
        write_read_sequence.start(environment.agent.sequencer);
        #300;
        phase.drop_objection(this);
    endtask

endclass
