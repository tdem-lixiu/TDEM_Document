        !COMPILER-GENERATED INTERFACE MODULE: Sat Jun 08 21:08:35 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE GET_PARAMETER__genmod
          INTERFACE 
            SUBROUTINE GET_PARAMETER(NE,ND,ND1,I3,NB1,XY,U1)
              INTEGER(KIND=4) :: ND1
              INTEGER(KIND=4) :: ND
              INTEGER(KIND=4) :: NE
              INTEGER(KIND=4) :: I3(3,NE)
              INTEGER(KIND=4) :: NB1(ND1)
              REAL(KIND=8) :: XY(2,ND)
              REAL(KIND=8) :: U1(ND1)
            END SUBROUTINE GET_PARAMETER
          END INTERFACE 
        END MODULE GET_PARAMETER__genmod
