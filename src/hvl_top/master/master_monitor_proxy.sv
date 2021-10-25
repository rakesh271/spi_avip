`ifndef MASTER_MONITOR_PROXY_INCLUDED_
`define MASTER_MONITOR_PROXY_INCLUDED_

//--------------------------------------------------------------------------------------------
//Class: master_monitor_proxy
//Class: master_monitor_proxy
//This is the HVL master monitor proxy
//It gets the sampled data from the HDL master monitor and 
//converts them into transaction items
//--------------------------------------------------------------------------------------------
class master_monitor_proxy extends uvm_component;
  `uvm_component_utils(master_monitor_proxy)

  //Parameter : Data length
  //Data length of Data_MOSI
  parameter DATA_LENGTH = 8;
  
  // Variable: m_cfg
  // Declaring handle for master agent config class 
  master_agent_config m_cfg;

 //Declaring Monitor Analysis Import
 uvm_analysis_port #(master_tx) ap;
  
  //Declaring Virtual Monitor BFM Handle
  virtual master_monitor_bfm m_mon_bfm_h;
  
  //Signal : MOSI Data-Input
  bit [DATA_LENGTH-1:0]data_miso;
  
  //Queue : data_mosi_q
  //Sets of Data_mosi data
  bit [DATA_LENGTH-1:0]data_miso_q[$];
 
 //declaring analysis port for the monitor port
 //uvm_analysis_port #(master_tx)monitor_port;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_monitor_proxy", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual task read_from_mon_bfm(bit CPOL,bit CPHA,bit miso);
  extern virtual task write(bit [DATA_LENGTH-1:0]data);

endclass : master_monitor_proxy

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_monitor_proxy
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function master_monitor_proxy::new(string name = "master_monitor_proxy",
                                 uvm_component parent = null);
  super.new(name, parent);
  ap = new("ap",this);  
  
  //creating monitor port
  
//  monitor_port=new("monitor_port",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void master_monitor_proxy::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db#(virtual master_monitor_bfm)::get(this,"","m_mon_bfm_h",m_mon_bfm_h)) begin
    `uvm_fatal("FATAL_SMP_MON_BFM",$formatf("Couldn't get S_MON_BFM in Master_Monitor_proxy"));
   end

endfunction : build_phase

//-------------------------------------------------------
//Task : read_from_mon_bfm
//Used to call the tasks from moitor bfm
//-------------------------------------------------------
task master_monitor_proxy::read_from_mon_bfm(bit CPOL,bit CPHA,bit miso);
   case({CPOL,CPHA})
     2'b00 : begin
                 
               // TODO(mshariff): 
               // MSHA: m_mon_bfm_h.sample_miso_pos_00(miso);
               // MSHA: $display("data_miso=%d",m_mon_bfm_h.data_miso);
               // MSHA: write(m_mon_bfm_h.data_miso);
              end

      2'b01 : begin 
               // TODO(mshariff): 
               // MSHA:  
               // MSHA: m_mon_bfm_h.sample_miso_neg_01(miso);
               // MSHA: write(m_mon_bfm_h.data_miso);      
              end
     
      2'b10 : begin                  
               // TODO(mshariff): 
              // MSHA:   
              // MSHA:  m_mon_bfm_h.sample_miso_pos_10(miso);
              // MSHA:  write(m_mon_bfm_h.data_miso);
             end
       2'b11 : begin
             // TODO(mshariff): 
             // MSHA:  
             // MSHA:   m_mon_bfm_h.sample_miso_neg_11(miso);
             // MSHA:   write(m_mon_bfm_h.data_miso);
                 end
               endcase
                                                      
endtask : read_from_mon_bfm

task  master_monitor_proxy::write(bit [DATA_LENGTH-1:0]data);

  // TODO(mshariff): Please work on cleaning up the code
  // MSHA: data_miso = data;
  // MSHA:   $display("WRITE__data_miso=%0d",data_miso);
  // MSHA:     data_mosi_q.push_front(data_miso);
  // MSHA:       ap.write(data_miso_q);
  // MSHA:       foreach(data_miso_q[i])
  // MSHA:       begin
  // MSHA:      $display(data_miso_q[i]);
  // MSHA:      end
  
endtask

//--------------------------------------------------------------------------------------------
// Task : run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task master_monitor_proxy::run_phase(uvm_phase phase);
     `uvm_info(get_type_name(), $sformatf("Inside the master_monitor_proxy"), UVM_LOW)
          repeat(1) begin
           
         // variable : CPOL
         // Clock Polarity 
          bit CPOL=0;
 
          //Signal : CPHA
          //Clock Phase
           bit CPHA=0;
                       
           //Signal : Miso
           //Master-in slave-Out
          // bit mosi;
          //Signal : Mosi
          //Master-out slave-in
          bit miso;
                 
          //Signal : CS
          //Chip Select
          //bit cs;
                                 
  //-------------------------------------------------------
  // Calling the tasks from monitor bfm
 //-------------------------------------------------------
        read_from_mon_bfm(CPOL,CPHA,miso);    
        end
         
          endtask : run_phase 


  // TODO(mshariff): Below is the dupliacted code
  // Please cleanup
  // MSHA: //-------------------------------------------------------
  // MSHA: // Task : Mon_bfm
  // MSHA: // Used to call the tasks from moitor bfm
  // MSHA: //-------------------------------------------------------
  // MSHA:   task master_monitor_proxy::read_from_mon_bfm(bit CPOL,bit CPHA,bit miso);
  // MSHA:    
  // MSHA:     case({CPOL,CPHA})
  // MSHA:    2'b00 : begin 
  // MSHA:             m_mon_bfm_h.sample_miso_pos_00(miso);
  // MSHA:             //Converting to transactions
  // MSHA:             write(m_mon_bfm_h.data_miso);
  // MSHA:             end
  // MSHA:    2'b01 : begin 
  // MSHA:            m_mon_bfm_h.sample_miso_neg_01(miso);
  // MSHA:            write(m_mon_bfm_h.data_miso);
  // MSHA:            end
  // MSHA:    2'b10 : begin                  
  // MSHA:            m_mon_bfm_h.sample_miso_pos_10(miso);
  // MSHA:            write(m_mon_bfm_h.data_miso);
  // MSHA:            end
  // MSHA:    2'b11 : begin
  // MSHA:            m_mon_bfm_h.sample_miso_neg_11(miso);
  // MSHA:            write(m_mon_bfm_h.data_miso);
  // MSHA:            end
  // MSHA:          endcase
  // MSHA:       
  // MSHA:     endtask : read_from_mon_bfm
    

  
 `endif
