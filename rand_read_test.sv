
class rand_read_test extends base_test;
    `uvm_component_utils(rand_read_test)

    rand_read_seq rand_read_sequence;

    function new(string name="rand_read_test", uvm_component parent);
        super.new(name,parent);
        `uvm_info("Rand Read Test", "Constructed Random Read Test", UVM_HIGH)
    endfunction

   task run_phase(uvm_phase phase);
       super.run_phase(phase);
       phase.raise_objection(this);
       reset_sequence = reset_seq::type_id::create("reset_sequence");
       rand_read_sequence = rand_read_seq::type_id::create("error_sequence");
       rand_read_sequence.set_no_of_tr(32);
       
       reset_sequence.start(environment.agent.sequencer);
       rand_read_sequence.start(environment.agent.sequencer);
       #300;
       phase.drop_objection(this);
   endtask

endclass


