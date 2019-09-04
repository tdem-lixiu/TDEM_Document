        !COMPILER-GENERATED INTERFACE MODULE: Sun Jun 09 14:22:57 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE E2K1__genmod
          INTERFACE 
            SUBROUTINE E2K1(NX,NY,ND,NE,XY,I4,ID,GA,NRO,RO)
              INTEGER(KIND=4) :: NE
              INTEGER(KIND=4) :: ND
              INTEGER(KIND=4) :: NY
              INTEGER(KIND=4) :: NX
              REAL(KIND=8) :: XY(2,ND)
              INTEGER(KIND=4) :: I4(4,NE)
              INTEGER(KIND=4) :: ID(ND)
              REAL(KIND=8) :: GA(*)
              INTEGER(KIND=4) :: NRO(NX,NY)
              REAL(KIND=8) :: RO(*)
            END SUBROUTINE E2K1
          END INTERFACE 
        END MODULE E2K1__genmod
