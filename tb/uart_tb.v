`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.01.2026 14:52:58
// Design Name: 
// Module Name: uart_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_tb;
    // Parameters
    parameter CLK_FREQ  = 50_000_000;   // 50 MHz
    parameter BAUD_RATE = 9600;
    // Testbench Signals
    reg clk;
    reg rst;

    reg  tx_start;
    reg [7:0]  tx_data;
    wire  tx_busy;

    wire  tx;
    wire  rx;

    wire [7:0] rx_data;
    wire rx_done;

    // Loopback Connection
    assign rx = tx;   // TX output fed back to RX input

    // DUT: UART TOP
    uart_top #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) dut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy),
        .rx(rx),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    always #10 clk = ~clk;

    // Task: Send One Byte

    task send_byte(input [7:0] data);
        begin
            @(posedge clk);
            tx_data  <= data;
            tx_start <= 1'b1;

            @(posedge clk);
            tx_start <= 1'b0;

            // Wait until transmission finishes
            wait(tx_busy == 1'b0);
        end
    endtask
    // Test Sequence
    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data  = 8'h00;

        // Apply reset
        #100;
        rst = 0;

        // TEST 1: Send 'A' (0x41)
        send_byte(8'h41);
        wait(rx_done);

        if (rx_data == 8'h41)
            $display("PASS: Received 'A' (0x41)");
        else
            $display("FAIL: Expected 0x41, Got %h", rx_data); //displayed in tcl console

        #200000;
        // TEST 2: Send 0x55
        send_byte(8'h55);
        wait(rx_done);

        if (rx_data == 8'h55)
            $display("PASS: Received 0x55");
        else
            $display("FAIL: Expected 0x55, Got %h", rx_data);

        #200000;
        // TEST 3: Send 0xFF
        send_byte(8'hFF);
        wait(rx_done);

        if (rx_data == 8'hFF)
            $display("PASS: Received 0xFF");
        else
            $display("FAIL: Expected 0xFF, Got %h", rx_data);

        #200000;

        // End Simulation
        $display("UART TOP MODULE SYSTEM TEST COMPLETED");
        $stop;
    end
endmodule
