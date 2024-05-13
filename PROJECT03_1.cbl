      ******************************************************************
      * Author: Mingzi Xu
      * Date: DEC.5.2023
      * Purpose: project 03
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. project03.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT STUDENT-INPUT-FILE
             ASSIGN TO "..\STUFILE3.txt"
             ORGANIZATION IS LINE SEQUENTIAL.

           SELECT INDEXED-STUDENT-FILE
             ASSIGN TO "..\indexed_stufile.index"
             ORGANIZATION IS INDEXED
             ACCESS MODE IS DYNAMIC
             RECORD KEY IS STUDENT-NUMBER-INDEXED
             ALTERNATE key IS STUDENT-NAME-INDEXED WITH DUPLICATES
             FILE STATUS IS STATUS-FILED.

       DATA DIVISION.
       FILE SECTION.
      ****************************
      *INPUT DATA OF STUDENT FILE*
      ****************************
       FD STUDENT-INPUT-FILE.
       01 STUDENT-INPUT.
           02 STUDENT-NUMBER              PIC 9(6).
           02 TUITION-OWED                PIC 9(4)V99.
           02 STUDENT-NAME                PIC X(40).
           02 PROGRAM-OF-STUDY            PIC X(6).
      ****************************
      * LOOPS X 5 COURSE AND AVE *
      ****************************
           02 COURSES                     OCCURS 5 TIMES.
             03 COURSE-CODE               PIC X(7).
             03 COURSE-AVERAGE            PIC 9(3).

       FD INDEXED-STUDENT-FILE.
       01 STUDENT-FILE-INDEXED.
           02 STUDENT-NUMBER-INDEXED      PIC 9(6).
           02 TUITION-OWED-INDEXED        PIC 9(4)V99.
           02 STUDENT-NAME-INDEXED        PIC X(40).
           02 PROGRAM-OF-STUDY-INDEXED    PIC X(6).
      ****************************
      * LOOPS X 5 COURSE AND AVE *
      ****************************
           02 COURSES-INDEXED             OCCURS 5 TIMES.
             03 COURSE-CODE-INDEXED       PIC X(7).
             03 COURSE-AVERAGE-INDEXED    PIC 9(3).

       WORKING-STORAGE SECTION.
       01 STATUS-FILED                    PIC X(2).
       01 EOF-FLAG                        PIC X(1) VALUE "N".
       01 WS-FIELDS.
         05 WS-COURSE-SUB                 PIC 9(2) VALUE 0.


       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
       OPEN INPUT STUDENT-INPUT-FILE
         OUTPUT INDEXED-STUDENT-FILE.

       PERFORM UNTIL EOF-FLAG = 'Y'
        READ STUDENT-INPUT-FILE
            AT END
                MOVE'Y' TO  EOF-FLAG
            NOT AT END
                MOVE STUDENT-NUMBER TO STUDENT-NUMBER-INDEXED
                MOVE TUITION-OWED TO TUITION-OWED-INDEXED
                MOVE STUDENT-NAME TO STUDENT-NAME-INDEXED
                MOVE PROGRAM-OF-STUDY TO PROGRAM-OF-STUDY-INDEXED
                PERFORM VARYING WS-COURSE-SUB
                     FROM 1 BY 1 UNTIL WS-COURSE-SUB > 5
                    MOVE COURSE-CODE(WS-COURSE-SUB)
                     TO COURSE-CODE-INDEXED(WS-COURSE-SUB)
                    MOVE COURSE-AVERAGE(WS-COURSE-SUB)
                     TO COURSE-AVERAGE-INDEXED(WS-COURSE-SUB)
                END-PERFORM
                WRITE STUDENT-FILE-INDEXED
        END-READ
       END-PERFORM.

       CLOSE STUDENT-INPUT-FILE.
       CLOSE   INDEXED-STUDENT-FILE.

       STOP RUN.
       END PROGRAM project03.
