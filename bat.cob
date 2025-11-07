       IDENTIFICATION DIVISION.
       PROGRAM-ID. BATTERY.
       AUTHOR.     MATHEW.
       DATE-WRITTEN. 11/05/2025.
       SECURITY. NON-CONFIDENTIAL.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
         SELECT CHARGE-NOW ASSIGN TO 
                 "/sys/class/power_supply/BAT0/charge_now"
                 ORGANIZATION IS LINE SEQUENTIAL.
         SELECT CHARGE-FULL ASSIGN TO
                 "/sys/class/power_supply/BAT0/charge_full"
                 ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD CHARGE-NOW.
       01 NOW-RECORD PIC X(7).

       FD CHARGE-FULL.
       01 FULL-RECORD PIC X(7).

       WORKING-STORAGE SECTION.
       01 BAT-NOW PIC 9(7).
       01 BAT-FULL PIC 9(7).
       01 BAT-PERC PIC 9(3)V99.
       PROCEDURE DIVISION.
       MAIN-LOGIC.
           OPEN INPUT CHARGE-NOW
           OPEN INPUT CHARGE-FULL

           READ CHARGE-NOW INTO NOW-RECORD
           READ CHARGE-FULL INTO FULL-RECORD
           
           MOVE NOW-RECORD TO BAT-NOW
           MOVE FULL-RECORD TO BAT-FULL

           IF BAT-FULL > 0 THEN
                   COMPUTE BAT-PERC = (BAT-NOW/BAT-FULL) * 100
           ELSE
                   DISPLAY "ERROR! FULL-CHARGE IS ZERO, CONNOT DIVIDE!"
                   MOVE 0 TO BAT-PERC
           END-IF

           DISPLAY "BATTERY: " BAT-PERC

           CLOSE CHARGE-NOW
           CLOSE CHARGE-FULL
           STOP RUN.
