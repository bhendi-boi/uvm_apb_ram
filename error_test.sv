class error_test extends base_test;
    `uvm_component_utils(error_test)

    error_seq error_sequence;

    function new(string name="error_test", uvm_component parent);
        super.new(name,parent);
        `uvm_info("Error Test", "Constructed Error Test", UVM_HIGH)
    endfunction

   task run_phase(uvm_phase phase);
       super.run_phase(phase);
       phase.raise_objection(this);
       reset_sequence = reset_seq::type_id::create("reset_sequence");
       error_sequence = error_seq::type_id::create("error_sequence");
       
       reset_sequence.start(environment.agent.sequencer);
       error_sequence.start(environment.agent.sequencer);
       #300;
       phase.drop_objection(this);
   endtask

endclass

