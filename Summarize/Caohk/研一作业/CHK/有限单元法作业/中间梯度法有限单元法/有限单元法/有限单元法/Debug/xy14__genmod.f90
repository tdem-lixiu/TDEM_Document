        !COMPILER-GENERATED INTERFACE MODULE: Sun Jun 09 14:22:57 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE XY14__genmod
          INTERFACE 
            SUBROUTINE XY14(NX,NY,X,Y,ND,NE,XY,I4)
              INTEGER(KIND=4) :: NY
              INTEGER(KIND=4) :: NX
              REAL(KIND=8) :: X(NX+1)
              REAL(KIND=8) :: Y(NY+1)
              INTEGER(KIND=4) :: ND
              INTEGER(KIND=4) :: NE
              REAL(KIND=8) :: XY(2,*)
              INTEGER(KIND=4) :: I4(4,*)
            END SUBROUTINE XY14
          END INTERFACE 
        END MODULE XY14__genmod
