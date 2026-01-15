`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.01.2026 23:24:58
// Design Name: 
// Module Name: uart_tx
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


module uart_tx #
(
    parameter CLK_FREQ = 50_000_000,   // 50 MHz
    parameter BAUD_RATE = 9600//9600 bits per second
)
(
    input clk,
    input rst,
    input tx_start,
    input [7:0] tx_data,
    output reg tx,
    output reg tx_busy
);

    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;//here 5208 clock cycles per bit

    reg [3:0] bit_index;//counts which bit is currently being transmitted
    reg [15:0] clk_count;
    reg [9:0] tx_shift;//shift register containing stop,data(8bits),start

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx <= 1'b1;        // Idle state
            tx_busy <= 1'b0;
            clk_count <= 0;
            bit_index <= 0;
        end
        else begin
            if (tx_start && !tx_busy) begin
                // Load frame: {Stop, Data, Start}
                tx_shift <= {1'b1, tx_data, 1'b0};//LSB bit_index0 goes out first
                tx_busy <= 1'b1;
                bit_index <= 0;
                clk_count <= 0;
            end
            else if (tx_busy) begin
                if (clk_count < CLKS_PER_BIT - 1)
                    clk_count <= clk_count + 1;
                else begin//we created this another else block because exactly one bit time has completed - now it is safe to move to the next bit
                    clk_count <= 0;
                    tx <= tx_shift[bit_index];
                    bit_index <= bit_index + 1;

                    if (bit_index == 9) begin
                        tx_busy <= 1'b0;
                        tx <= 1'b1; // Return to idle
                    end
                end
            end
        end
    end
endmodule