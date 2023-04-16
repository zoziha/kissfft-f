program main
    use kissfft
    type(kiss_fft_cpx) :: in(4), out(4)
    type(fft) :: fft_obj
    integer :: i
    do i = 1, 4
        in(i)%re = i
        in(i)%im = 0
    end do
    call fft_obj%init(4, 0)
    call fft_obj%perform(in, out)
    call fft_obj%init(4, 1)
    call fft_obj%perform(out, out)
    do i = 1, 4
        print *, out(i)%re, out(i)%im
    end do
end program main
!  4.00000000       0.00000000
!  8.00000000       0.00000000
!  12.0000000       0.00000000
!  16.0000000       0.00000000