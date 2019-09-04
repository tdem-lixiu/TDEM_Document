        !COMPILER-GENERATED INTERFACE MODULE: Sat Jun 08 21:08:35 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE LDLT__genmod
          INTERFACE 
            SUBROUTINE LDLT(A,N,IW,P,IE)
              INTEGER(KIND=4) :: IW
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: A(N,IW)
              REAL(KIND=8) :: P(N)
              INTEGER(KIND=4) :: IE
            END SUBROUTINE LDLT
          END INTERFACE 
        END MODULE LDLT__genmod
