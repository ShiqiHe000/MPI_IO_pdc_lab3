
PROGRAM TRY

    USE MPI
    IMPLICIT NONE
    
    INTEGER :: RANK, PROC, IERROR
    INTEGER :: FH
    INTEGER :: ISIZE
    INTEGER :: STATUS(MPI_STATUS_SIZE)
    INTEGER(KIND=MPI_OFFSET_KIND) :: OFFSET
    INTEGER :: DATA(4)
    
    CALL MPI_INIT(IERROR)
    CALL MPI_COMM_RANK(MPI_COMM_WORLD, RANK, IERROR)
    CALL MPI_TYPE_SIZE(MPI_INTEGER, ISIZE, IERROR) !Returns the number of bytes occupied by entries in a data type. 

        
    
        ! MPI_COMM_SELF -- JUST ONE PROCESS
        CALL MPI_FILE_OPEN(MPI_COMM_WORLD, 'file.bin', MPI_MODE_CREATE + &
                            MPI_MODE_WRONLY, MPI_INFO_NULL, FH, IERROR)
        
        DATA = RANK
        OFFSET = RANK*4*ISIZE
        
        ! you can use mpi_file_seek + mpi_file_write_at or
        ! mpi_file_set_view + mpi_file_write


!        CALL MPI_FILE_SEEK(FH, OFFSET, MPI_SEEK_SET, IERROR)                    
                            
        CALL MPI_FILE_SET_VIEW(FH, OFFSET, MPI_INTEGER, MPI_INTEGER, &
                'NATIVE', MPI_INFO_NULL, IERROR)

        CALL MPI_FILE_WRITE(FH, DATA, 4, MPI_INTEGER, STATUS, IERROR)

!        CALL MPI_FILE_WRITE_AT(FH, OFFSET, DATA, 4, &
!                        MPI_INTEGER, STATUS, IERROR)


        CALL MPI_FILE_CLOSE(FH, IERROR)
    
    
    CALL MPI_FINALIZE(IERROR)

END PROGRAM TRY
