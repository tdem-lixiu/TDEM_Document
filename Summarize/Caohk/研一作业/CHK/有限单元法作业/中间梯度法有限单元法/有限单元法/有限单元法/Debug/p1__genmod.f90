        !COMPILER-GENERATED INTERFACE MODULE: Sun Jun 09 14:22:57 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE P1__genmod
          INTERFACE 
            SUBROUTINE P1(E0,NX,NY,ND,NE,XY,I4,NRO,RO,P)
              INTEGER(KIND=4) :: NE
              INTEGER(KIND=4) :: ND
              INTEGER(KIND=4) :: NY
              INTEGER(KIND=4) :: NX
              REAL(KIND=8) :: E0
              REAL(KIND=8) :: XY(2,ND)
              INTEGER(KIND=4) :: I4(4,NE)
              INTEGER(KIND=4) :: NRO(NX,NY)
              REAL(KIND=8) :: RO(*)
              REAL(KIND=8) :: P(ND)
            END SUBROUTINE P1
          END INTERFACE 
        END MODULE P1__genmod
