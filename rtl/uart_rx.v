`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.01.2026 00:33:21
// Design Name: 
// Module Name: uart_rx
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


module uart_rx #
(
    parameter CLK_FREQ  = 50_000_000,
    parameter BAUD_RATE = 9600
)
(
    input  clk,
    input  rst,
    input  rx,
    output reg [7:0] rx_data,
    output reg rx_done
);

    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

    reg [15:0] clk_count;
    reg [3:0]  bit_index;
    reg rx_busy;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            rx_busy   <= 0;
            clk_count <= 0;
            bit_index <= 0;
            rx_data   <= 0;
            rx_done   <= 0;
        end
        else begin
            rx_done <= 0;

            // IDLE: WAIT FOR START BIT
            if (!rx_busy) begin
                clk_count <= 0;
                if (rx == 1'b0) begin //start bit
                    rx_busy   <= 1'b1;
                    bit_index <= 0;
                end
            end

            //RECEIVING
            else begin
                clk_count <= clk_count + 1;

                // First data bit sample (1.5 bit time)
                if (clk_count == (CLKS_PER_BIT + CLKS_PER_BIT/2)) begin
                    rx_data[0] <= rx;
                    bit_index  <= 1;
                end

                // Remaining bits (every 1 bit time)
                else if (bit_index > 0 &&
                         clk_count == (CLKS_PER_BIT + CLKS_PER_BIT/2)
                                      + bit_index*CLKS_PER_BIT &&
                         bit_index < 8) begin
                    rx_data[bit_index] <= rx;
                    bit_index <= bit_index + 1;
                end

                // Done after last data bit
                else if (bit_index == 8 &&
                         clk_count == (CLKS_PER_BIT + CLKS_PER_BIT/2)
                                      + 8*CLKS_PER_BIT) begin
                    rx_busy <= 0;
                    rx_done <= 1;
                end
            end
        end
    end
endmodule

