        !COMPILER-GENERATED INTERFACE MODULE: Sat Jun 08 21:08:35 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE UK1__genmod
          INTERFACE 
            SUBROUTINE UK1(ND,NE,IW,I3,XY,SK)
              INTEGER(KIND=4) :: IW
              INTEGER(KIND=4) :: NE
              INTEGER(KIND=4) :: ND
              INTEGER(KIND=4) :: I3(3,NE)
              REAL(KIND=8) :: XY(2,ND)
              REAL(KIND=8) :: SK(ND,IW)
            END SUBROUTINE UK1
          END INTERFACE 
        END MODULE UK1__genmod
