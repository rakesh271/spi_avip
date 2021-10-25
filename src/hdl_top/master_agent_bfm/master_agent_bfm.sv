`ifndef MASTER_AGENT_BFM_INCLUDED_
`define MASTER_AGENT_BFM_INCLUDED_

  //--------------------------------------------------------------------------------------------
  // Module : Master_agent_bfm
  // Description : Instantiate driver and monitor
  //--------------------------------------------------------------------------------------------

  module master_agent_bfm(spi_if intf);

  //-------------------------------------------------------
  // Package : Importing Uvm Pakckage and Test Package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh"

   initial
   begin
      $display("Master Agent BFM");
   end
  //--------------------------------------------------------------------------------------------
  // Master Driver bfm 
  //--------------------------------------------------------------------------------------------
   master_driver_bfm m_drv_bfm_h (intf.MAS_DRV_MP,intf.MON_MP);
  
  //--------------------------------------------------------------------------------------------
  // Master Monitor bfm
  //--------------------------------------------------------------------------------------------
   master_monitor_bfm master_monitor_bfm_h (intf.MON_MP);

  //-------------------------------------------------------
  // Setting master_driver_bfm and monitor_bfm
  //-------------------------------------------------------
  initial begin
    uvm_config_db#(virtual master_driver_bfm)::set(null,"*", "master_driver_bfm", m_drv_bfm_h); 
    uvm_config_db#(virtual master_monitor_bfm)::set(null,"*", "master_monitor_bfm", master_monitor_bfm_h); 
  end

  endmodule : master_agent_bfm

`endif
