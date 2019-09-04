        !COMPILER-GENERATED INTERFACE MODULE: Sat Jun 15 23:23:09 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE UK1__genmod
          INTERFACE 
            SUBROUTINE UK1(ND,NE,IW,I3,XY,SK)
              INTEGER(KIND=8) :: IW
              INTEGER(KIND=8) :: NE
              INTEGER(KIND=8) :: ND
              INTEGER(KIND=8) :: I3(3,NE)
              REAL(KIND=8) :: XY(2,ND)
              REAL(KIND=8) :: SK(ND,IW)
            END SUBROUTINE UK1
          END INTERFACE 
        END MODULE UK1__genmod
