//--------------------------------------------------------------------------------------------
// Module: Hvl top module
//--------------------------------------------------------------------------------------------
module hvl_top;

  //-------------------------------------------------------
  // Package : Importing Uvm Pakckage and Test Package
  //-------------------------------------------------------
  import test_pkg::*;
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Declaring SPI and Slave_driver_bfm Interface
  //-------------------------------------------------------
  spi_if vif();
  slave_monitor_bfm s_mon_bfm_h(vif.MON_MP);
  master_monitor_bfm m_mon_bfm_h(vif.MON_MP);

  //-------------------------------------------------------
  // run_test for simulation
  //-------------------------------------------------------
  initial begin
    //-------------------------------------------------------
    // Setting SPI Interface
    //-------------------------------------------------------

    uvm_config_db #(virtual spi_if)::set(null,"*","spi_if",vif); 
    
    run_test("base_test");
  end

endmodule : hvl_top
