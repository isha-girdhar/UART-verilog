# UART-Verilog
This project implements a Verilog-based *UART (Universal Asynchronous Receiver Transmitter)* for serial communication. It supports asynchronous data transmission and reception using standard UART protocol. A testbench is included to simulate and verify the design.

# 📡 UART Controller in Verilog

A *UART* (Universal Asynchronous Receiver Transmitter) is a widely used serial communication protocol that enables asynchronous data transfer between devices without requiring a shared clock.  
This project demonstrates the complete implementation of a *UART Transmitter (TX)* and *UART Receiver (RX)* using Verilog HDL.

---

## 📌 Description

The UART operates based on asynchronous serial communication principles:

- Data transmission begins with a **start bit**, followed by **data bits**, and ends with a **stop bit**.  
- Transmission and reception are controlled by a predefined baud rate.  
- The design is modular and consists of:
  - *UART Transmitter (TX)* → Converts parallel data into serial format.  
  - *UART Receiver (RX)* → Converts serial data back into parallel format.  
  - *Top Module* → Integrates TX and RX for easy interfacing.

---

## 🧠 Features

- Asynchronous serial communication protocol  
- Separate **TX** and **RX** modules  
- Top-level UART integration  
- FSM-based transmitter and receiver logic  
- Testbench included for functional verification  
- Fully synthesizable Verilog HDL design  

---

## 📁 Project Structure
```
UART-Verilog/
├── rtl/
│ ├── uart_top.v # Top-level UART module
│ ├── uart_tx.v # UART transmitter
│ └── uart_rx.v # UART receiver
│
├── tb/
│ └── uart_tb.v # UART testbench
│
├── images/
│ ├── schematic.png # RTL schematic
│ └── simulation.png # Simulation waveform
│
├── README.md # Project documentation
└── .gitignore
```

---

## 📦 Module Overview

### 🔧 uart_tx.v

Implements the UART transmitter functionality.

- *Inputs*  
  - clk → System clock  
  - rst → Reset signal  
  - tx_start → Start transmission  
  - tx_data [7:0] → Parallel input data  

- *Outputs*  
  - tx → Serial data output  
  - tx_busy → Indicates transmission in progress  

---

### 🔧 uart_rx.v

Implements the UART receiver functionality.

- *Inputs*  
  - clk → System clock  
  - rst → Reset signal  
  - rx → Serial data input  

- *Outputs*  
  - rx_data [7:0] → Received parallel data  
  - rx_done → Indicates successful reception  

---

### 🔧 uart_top.v

Top-level module integrating UART TX and RX.

- Instantiates transmitter and receiver modules  
- Manages data flow between TX and RX  
- Simplifies external interfacing  

---

### 📐 uart_tb.v

The testbench validates the UART design by:

- Generating clock and reset signals  
- Initiating data transmission  
- Observing serial output behavior  
- Verifying correct UART operation through simulation  

---

## ▶ Simulation

### 📷 Simulation Waveform
The simulation waveform verifies:
- Start bit, data bits, and stop bit generation  
- Correct serial transmission timing  
- Proper UART behavior  

<img width="1485" height="648" alt="simulation" src="https://github.com/user-attachments/assets/821a90ff-5961-42eb-904f-4a361b341d40" />


---

### 📷 RTL Schematic
The RTL schematic shows:
- UART TX and RX blocks  
- Control logic and data paths  
- Top-level module integration  

<img width="1226" height="616" alt="schematic" src="https://github.com/user-attachments/assets/5c6d929a-b2e6-48f3-94f3-b587157aac7f" />


---

## 💻 Requirements

- *Xilinx Vivado / ModelSim / Any Verilog simulator*  
- Basic understanding of UART protocol  
- Knowledge of digital design and FSM concepts  

---

## 📝 License  

This project is licensed under the **MIT License**.  

---

## 👩‍💻 Author  

**Isha Rani**  

---
