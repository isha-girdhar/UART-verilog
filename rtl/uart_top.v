`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.01.2026 14:48:39
// Design Name: 
// Module Name: uart_top
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


module uart_top #
(
    parameter CLK_FREQ  = 50_000_000,   // System clock
    parameter BAUD_RATE = 9600
)
(
    input  clk,
    input  rst,

    // -------- Transmitter Interface --------
    input tx_start,
    input  [7:0] tx_data,
    output tx,
    output tx_busy,

    // -------- Receiver Interface --------
    input rx,
    output [7:0] rx_data,
    output rx_done
);

    // -------------------------------
    // UART Transmitter Instance
    // -------------------------------
    uart_tx #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) u_tx (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    // -------------------------------
    // UART Receiver Instance
    // -------------------------------
    uart_rx #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) u_rx (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

endmodule
