      ******************************************************************
      * Author: Mingzi Xu
      * Date: DEC.5.2023
      * Purpose: project 03
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. YOUR-PROGRAM-NAME.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
          SELECT INDEXED-STUDENT-FILE
             ASSIGN TO "..\indexed_stufile.index"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             RECORD KEY IS STUDENT-NUMBER-INDEXED
             ALTERNATE key IS STUDENT-NAME-INDEXED WITH DUPLICATES
             FILE STATUS IS STATUS-FILED.
       DATA DIVISION.
       FILE SECTION.
       FD INDEXED-STUDENT-FILE.
       01 STUDENT-FILE-INDEXED.
           02 STUDENT-NUMBER-INDEXED      PIC 9(6).
           02 TUITION-OWED-INDEXED        PIC 9(4)V99.
           02 STUDENT-NAME-INDEXED        PIC X(40).
           02 PROGRAM-OF-STUDY-INDEXED    PIC X(6).
           02 COURSES-INDEXED             PIC X(50).


         WORKING-STORAGE SECTION.
           01 STATUS-FILED               PIC X(2).
           01 WS-STUDENT-NUMBER           PIC 9(6).
           01 WS-TUITION-OWED             PIC 9(5)V99.
           01 WS-PAYMENT-AMOUNT           PIC 9(5)V99 .
           01 WS-FIELDS.
             02 WS-COURSE-SUB               PIC 9(2) VALUE 0.
             02 WS-UPDATE-FLAG              PIC X VALUE 'N'.
             02 WS-FOUND-FLAG               PIC X VALUE 'N'.
           01 EOF-FLAG                        PIC X(1) VALUE "N".
           01 WS-CHOICE PIC X(1).
           01 WS-REAEARCH-CHOICE-IN       PIC X.
       SCREEN SECTION.
       01 INPUT-SCREEN.
         05 VALUE "***************" BLANK SCREEN   LINE 1 COL 20.
          05 VALUE "*****INPUT*****"               LINE 2 COL 20.
          05 VALUE "***************"               LINE 3 COL 20.
          05 VALUE "PLEASE ENTER THE STUDENT NUMBER YOU WANT TO UPDATED"
                                                   LINE 5 COL 5.
          05 VALUE "STUDENT NUMBER"                LINE 8 COL 5.
          05 STUDENT-NUMBER-IN                     LINE 8 COL 25
                             PIC 9(6)  TO  WS-STUDENT-NUMBER.

       01  ERROR-SCREEN.
        05 VALUE "***************" BLANK SCREEN    LINE 1 COL 10.
          05 VALUE "*****ERROR*****"               LINE 2 COL 10.
          05 VALUE "***************"               LINE 3 COL 10.

           05 VALUE "CANNOT FIND THESTUDENT NUMBER"   LINE 6 COL 5.

           05 VALUE "ANOTHER RESEARCH (Y/N) ?"     LINE 7 COL 5.
           05 WS-CHOICE-IN                         LINE 7 COL 30
                           PIC X(1)  TO  WS-CHOICE.
       01  USING-SCREEN.
           05 VALUE "***************" BLANK SCREEN  LINE 1 COL 20.
           05 VALUE "****USING*****"                 LINE 2 COL 20.
           05 VALUE "***************"                LINE 3  COL 20.

           05 VALUE "STUDENT NUMBER"                 LINE 6 COL 5.
           05 STUDENT-NUMBER-USING                   LINE 6 COL 50
                   PIC  9(6) FROM WS-STUDENT-NUMBER.
          05 VALUE "STUDENT NAME"                    LINE 8 COL 5.
          05 STUDENT-NAME-USING                      LINE 8 COL 50
                       PIC X(40) FROM STUDENT-NAME-INDEXED.

          05 VALUE "STUDENT TUITION OWNED"           LINE 10 COL 5.
          05 TUITION-OWED-USING                      LINE 10 COL 50
                       PIC ZZZZ9.99 FROM TUITION-OWED-INDEXED.

          05 VALUE "STUDENT PROGRAM"                 LINE 12 COL 5.
          05 PROGRAM-OF-STUDY-USING                  LINE 12 COL 50
                      PIC X(6) FROM PROGRAM-OF-STUDY-INDEXED.
          05 VALUE "STUDENT COURSES"                 LINE 14 COL 5.

          05 COURSES-INDEXED-USING                   LINE 14 COL 50
                       PIC X(50) FROM COURSES-INDEXED.
          05 VALUE "ENTER THE PAYMENT OF STUDENT TUITION"
                                                     LINE 16 COL 5.
          05 STUDENT-PAYMENT-IN                      LINE 16 COL 50
                       PIC ZZZZ9.99 TO WS-PAYMENT-AMOUNT.

       01  OUTPUT-SCREEN.
           05 VALUE "***************" BLANK SCREEN  LINE 1 COL 20.
           05 VALUE "****OUTPUT*****" BLANK SCREEN LINE 1 COL 20.
           05 VALUE "***************"                LINE 2  COL 20.

           05 VALUE "STUDENT NUMBER"                 LINE 6 COL 5.
           05 STUDENT-NUMBER-OUT                     LINE 6 COL 40
                         PIC  X(6) FROM WS-STUDENT-NUMBER.

           05 VALUE "STUDENT NAME"                   LINE 8 COL 5.
           05 STUDENT-NAME-OUT                       LINE 8 COL 40
                         PIC X(40) FROM STUDENT-NAME-INDEXED.

           05 VALUE "STUDENT TUITION OWNED"          LINE 10 COL 5.
           05 TUITION-OWED-OUT                       LINE 10 COL 40
                         PIC $ZZZ9.99 FROM TUITION-OWED-INDEXED.

           05 VALUE "STUDENT PROGRAM"                LINE 12 COL 5.
           05 PROGRAM-OF-STUDY-OUT                   LINE 12 COL 40
                         PIC X(6) FROM PROGRAM-OF-STUDY-INDEXED.

           05 VALUE "STUDENT COURSES"                LINE 14 COL 5.
           05 COURSES-INDEXED-OUT                    LINE 14 COL 40
                         PIC X(50) FROM COURSES-INDEXED.
           05 VALUE "ANOTHER RESEARCH  (Y/N) ?"      LINE 16 COL 5.
           05 WS-CHOICE-OUT                          LINE 16 COL 40
                           PIC X(1)  USING  WS-CHOICE.
        PROCEDURE DIVISION.
        MAIN-PROCEDURE.
           OPEN I-O INDEXED-STUDENT-FILE.
           PERFORM 100-INI-FILE.
        100-END-PROGRAM.
           CLOSE INDEXED-STUDENT-FILE.
           STOP RUN.

       100-INI-FILE.
           DISPLAY INPUT-SCREEN.
           ACCEPT INPUT-SCREEN.
           PERFORM 200-SEARCH-UPDATE.


       200-SEARCH-UPDATE.
            MOVE 'N' TO WS-FOUND-FLAG
            MOVE WS-STUDENT-NUMBER TO STUDENT-NUMBER-INDEXED
            WS-UPDATE-FLAG.
            PERFORM UNTIL WS-FOUND-FLAG = 'Y'
               READ INDEXED-STUDENT-FILE  KEY IS STUDENT-NUMBER-INDEXED
                 INVALID KEY
                   DISPLAY ERROR-SCREEN
                   ACCEPT WS-CHOICE-IN
                   IF WS-CHOICE-IN = 'Y'
                       PERFORM 100-INI-FILE
                      ELSE
                         PERFORM 100-END-PROGRAM
                   END-IF
                 NOT INVALID KEY
                    MOVE 'Y' TO WS-FOUND-FLAG
                    DISPLAY "STUDENT RECORD FOUND"
                    PERFORM UPDATE-STUDENT-INFO

              END-READ
            END-PERFORM.
        UPDATE-STUDENT-INFO.
           DISPLAY USING-SCREEN.
           ACCEPT STUDENT-PAYMENT-IN.
           COMPUTE
               TUITION-OWED-INDEXED =
                   TUITION-OWED-INDEXED - WS-PAYMENT-AMOUNT.

           OPEN OUTPUT INDEXED-STUDENT-FILE.

           REWRITE STUDENT-FILE-INDEXED.
           IF STATUS-FILED = '00'
              DISPLAY "Record Updated Successfully."
           ELSE
              DISPLAY "Failed to Update Record." .
           DISPLAY OUTPUT-SCREEN.
           ACCEPT WS-CHOICE-OUT
           IF WS-CHOICE-OUT = 'Y'
                       PERFORM 100-INI-FILE
                      ELSE
                        PERFORM 100-END-PROGRAM
                   END-IF.
       END PROGRAM YOUR-PROGRAM-NAME.
