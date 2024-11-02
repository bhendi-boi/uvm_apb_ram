class seqr extends uvm_sequencer #(transaction);
  `uvm_component_utils(seqr)

  function new(string name = "seqr", uvm_component parent);

    super.new(name, parent);
    `uvm_info("Sequencer", "Constructed sequencer", UVM_HIGH)
  endfunction

endclass

