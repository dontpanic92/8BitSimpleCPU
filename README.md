# 8BitSimpleCPU

哈工大电子技术实验

总线结构，具备8个8位通用寄存器。

#指令集

r0~r7: 000 ～ 111，用xxx表示。

Imm: 立即数，使用immmmmmm表示。

```
mov a,b
    mov r1,r2       00000 xxx 00000 xxx
    mov r1,[Imm]       00011 xxx immmmmmm
    mov [Imm],r2       00010 xxx immmmmmm
    mov r1,0x00     00001 xxx immmmmmm

adc a,b
    adc r1,r2       00100 xxx 00000 xxx
    adc r1,0x00     00101 xxx immmmmmm

sbb a,b
    sbb r1,r2       00110 xxx 00000 xxx
    sbb r1,0x00     00111 xxx immmmmmm

and a,b
    and r1,r2       01000 30rr
    and r1,0x00     01001 31rF

or a,b
    or r1,r2        01010 40rr
    or r1,0x00      01011 41rF

clc                 01100 50
stc                 01101 51

jmp addr            01110 60
jz  sign            01111 61
jc  sign            10000 62
```
