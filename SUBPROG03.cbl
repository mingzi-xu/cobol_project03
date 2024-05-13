      ******************************************************************
      * Author: Mingzi Xu
      * Date: DEC.5.2023
      * Purpose: project 03
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SUBPROG03.
       DATA DIVISION.

       LINKAGE SECTION.
       01 STUDENT-INPUT.
           05 STUDENT-NUMBER        PIC 9(6).
           05 TUITION-OWED          PIC 9(4)V99.
           05 STUDENT-NAME          PIC X(40).
           05 PROGRAM-OF-STUDY      PIC X(6).

           05 COURSE-CODE-1    PIC X(7).
           05 COURSE-AVERAGE-1 PIC 9(3).
           05 COURSE-CODE-2    PIC X(7).
           05 COURSE-AVERAGE-2 PIC 9(3).
           05 COURSE-CODE-3    PIC X(7).
           05 COURSE-AVERAGE-3 PIC 9(3).
           05 COURSE-CODE-4    PIC X(7).
           05 COURSE-AVERAGE-4 PIC 9(3).
           05 COURSE-CODE-5    PIC X(7).
           05 COURSE-AVERAGE-5 PIC 9(3).
       01 LS-WS-AVERAGE             PIC 999V.

       PROCEDURE DIVISION using STUDENT-INPUT,LS-WS-AVERAGE.
        MAIN-PROCEDURE.
           100-STUDENT-AVERAGE.

               PERFORM 300-CALCULATE-AVERAGE-RTN.

           300-CALCULATE-AVERAGE-RTN.
             COMPUTE LS-WS-AVERAGE ROUNDED = (COURSE-AVERAGE-1 +
               COURSE-AVERAGE-2 + COURSE-AVERAGE-3 + COURSE-AVERAGE-4 +
               COURSE-AVERAGE-5) / 5.

        GOBACK.
       END PROGRAM SUBPROG03.
