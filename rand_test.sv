class rand_test extends base_test;
    `uvm_component_utils(rand_test)

    rand_read_seq rand_read_sequence;
    rand_write_seq rand_write_sequence;
    error_seq error_sequence;

    function new(string name="rand_test", uvm_component parent);
        super.new(name,parent);
        `uvm_info("Rand Test", "Constructed Rand Test", UVM_HIGH)
    endfunction

   task run_phase(uvm_phase phase);
       super.run_phase(phase);
       phase.raise_objection(this);
       reset_sequence = reset_seq::type_id::create("reset_sequence");
       rand_read_sequence = rand_read_seq::type_id::create("read_sequence");
       rand_write_sequence = rand_write_seq::type_id::create("write_sequence");
       rand_read_sequence.set_no_of_tr(1024);
       rand_write_sequence.set_no_of_tr(1024);
       error_sequence = error_seq::type_id::create("error_sequence");
       
       reset_sequence.start(environment.agent.sequencer);
       rand_write_sequence.start(environment.agent.sequencer);
       rand_read_sequence.start(environment.agent.sequencer);
       error_sequence.start(environment.agent.sequencer);
       #300;
       phase.drop_objection(this);
   endtask

endclass


