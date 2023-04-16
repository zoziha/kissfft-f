program main
    use kissfft
    type(kiss_fft_cpx), dimension(4, 4) :: in, out
    type(fft) :: fft_obj
    integer :: i, j
    do j = 1, 4
        do i = 1, 4
            in(i, j)%re = i*j
            in(i, j)%im = 0.0
        end do
    end do
    call fft_obj%init_nd([4, 4], 2, 0)
    call fft_obj%perform_nd(in, out)
    do j = 1, 4
        do i = 1, 4
            write (*, '(sp,g0.4,sp,g0.4, ", ")', advance='no') out(i, j)%re, out(i, j)%im
        end do
        write (*, *)
    end do
end program main
! +100.0+0.000, -20.00+20.00, -20.00+0.000, -20.00-20.00,
! -20.00+20.00, +0.000-8.000, +4.000-4.000, +8.000+0.000,
! -20.00+0.000, +4.000-4.000, +4.000+0.000, +4.000+4.000,
! -20.00-20.00, +8.000+0.000, +4.000+4.000, +0.000+8.000,