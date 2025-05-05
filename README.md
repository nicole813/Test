
# Pipelined CPU 實作

以 Verilog HDL 搭配 ModelSim 模擬器實作一個五階段 pipeline 的 MIPS-Lite CPU。  

參考課本 Chapter 4 與課程講義之 Pipelined Datapath，設計一個 Pipelined 
MIPS-Lite CPU。

<br>

## 實現指令
完成下列16道指令  
a) Integer Arithmetic: **add, sub, and, or, sll, slt, andi**  
b) Integer Memory Access:  **lw, sw**  
c) Integer Branch: beq, **j, jr**  
d) Integer Multiply/Divide: **multu**  
e) Other Instructions: **mfhi, mflo, nop**  

<br>

## Datapath
![Pipelined Datapath](images/datapath.png)
![Pipelined Datapath](images/datapath2.png)
  
<br>

## waveform
![waveform](images/waveform.png)
![waveform](images/waveform2.png)

<br>

## result
![result](images/result.png)
