
`ifndef ENV_INCLUDED_
`define ENV_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: env
// Description:
// Environment contains slave_agent_top and slave_virtual_sequencer
//--------------------------------------------------------------------------------------------
class env extends uvm_env;

//-------------------------------------------------------
// Factory registration to create uvm_method and override it
//-------------------------------------------------------
  `uvm_component_utils(env)
  
      env_config e_cfg_h;
//-------------------------------------------------------
// declaring master handles
//-------------------------------------------------------
      master_agent ma_h;
 
      virtual_sequencer vseqr;

//-------------------------------------------------------
// Declaring slave handles
//-------------------------------------------------------
      slave_agent sa_h;

//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "env", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : env

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - env
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
  function env::new(string name = "env",uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Description:
//  Create required components
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
  function void env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info(get_full_name(),"ENV: build_phase",UVM_LOW);

      vseqr = virtual_sequencer::type_id::create("vseqr", this);

      ma_h = master_agent::type_id::create("master_agent",this);
      // TODO(mshariff): Create the agents based on the number of slaves
      sa_h = slave_agent::type_id::create("slave_agent",this);

  endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Description:
//  To connect driver and sequencer
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
  function void env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);

   vseqr.m_seqr_h = ma_h.m_sqr_h;
   vseqr.s_seqr_h = sa_h.s_sqr_h;
  endfunction : connect_phase

`endif

