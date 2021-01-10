*-----------------------------------------------------------
* Title      : Lab7e
* Written by : Karina Garmendez
* Date       : November 14 2020
* Description: TRAP #0 exception program
*-----------------------------------------------------------

* Goal: to switch from user state to supervisor and back after each TRAP #0
* "processor should return in user mode"-> <check!>

      ORG    $1000
T0VN  EQU    32+0           ; trap 0 vector number: 32 (0 + 32)
T0VA  EQU    T0VN*4         ; trap 0 vector address: 128 (32 * 4)

START:  MOVE.L #TRAP0,T0VA  ; first instruction of program

* switching to user / supervisor state and clearnign memory (16 bytes)

        LEA  $9000,A1
        LEA  $9010,A2
        ANDI #$DFFF,SR
        BSR  MAIN
        NOP

TRAP0:  CMPA.L A2,A1
        BHS    DONE
        CLR.B  (A1)+
        BRA    TRAP0
DONE:   RTE

* main subroutine for testing
      ORG $8000
MAIN:   TRAP #0         ; S = 1    
        TRAP #0         ; S = 0
        TRAP #0         ; S = 1
        TRAP #0         ; S = 0
    SIMHALT             ; halt simulator


    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
