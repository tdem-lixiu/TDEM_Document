        !COMPILER-GENERATED INTERFACE MODULE: Sat Jun 08 21:08:35 2019
        ! This source file is for reference only and may not completely
        ! represent the generated interface used by the compiler.
        MODULE OUTPUT_DATA__genmod
          INTERFACE 
            SUBROUTINE OUTPUT_DATA(ND,XY,U)
              INTEGER(KIND=4) :: ND
              REAL(KIND=8) :: XY(2,ND)
              REAL(KIND=8) :: U(ND)
            END SUBROUTINE OUTPUT_DATA
          END INTERFACE 
        END MODULE OUTPUT_DATA__genmod
