class rand_write_test extends base_test;
    `uvm_component_utils(rand_write_test)

    rand_write_seq rand_write_sequence;

    function new(string name="rand_write_test", uvm_component parent);
        super.new(name,parent);
        `uvm_info("Rand Write Test", "Constructed Random Write Test", UVM_HIGH)
    endfunction

   task run_phase(uvm_phase phase);
       super.run_phase(phase);
       phase.raise_objection(this);
       reset_sequence = reset_seq::type_id::create("reset_sequence");
       rand_write_sequence = rand_write_seq::type_id::create("error_sequence");
       rand_write_sequence.set_no_of_tr(32);
       
       reset_sequence.start(environment.agent.sequencer);
       rand_write_sequence.start(environment.agent.sequencer);
       #300;
       phase.drop_objection(this);
   endtask

endclass


