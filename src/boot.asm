; Learn ASM
; Lesson 2: A simple "Hello, world" program, which uses a simple print procedure.

BITS 16

JMP NEAR main

text1: DB "Hello, world! Now we can print text easily."

main:
    ; Initialize
    MOV AX, 0x07C0
    MOV DS, AX

    MOV AX, 0xB800
    MOV ES, AX

    ; Prepare for the print procedure

    MOV SI, text1
    MOV DI, 0
    MOV CX, main - text1

Print:
    MOV AL, [SI]
    MOV [ES:DI], AL
    INC DI
    MOV BYTE [ES:DI], 0x03
    INC DI
    INC SI
    LOOP Print ; Loop: DS:SI -> ES:DI, length = CX

JMP NEAR $

TIMES 510-($-$$) DB 0x00

DW 0xAA55