! This file is part of kissfft-f.
! SPDX-Identifier: BSD-3-Clause
module kissfft
    use, intrinsic :: iso_c_binding
    private
    public :: fft, kiss_fft_cpx, fftshift, ifftshift
    type fft
        type(c_ptr) :: kiss_fft_cfg
    contains
        procedure :: init, init_nd
        procedure :: perform, perform_nd
        procedure :: free
    end type fft
    type, bind(c) :: kiss_fft_cpx
        real(c_float) :: re
        real(c_float) :: im
    end type kiss_fft_cpx
    interface
        function kiss_fft_alloc(nfft, inverse_fft, mem, lenmem) bind(c, name="kiss_fft_alloc") result(kiss_fft_cfg)
            import
            integer(c_int), value :: nfft
            integer(c_int), value :: inverse_fft
            type(c_ptr), value :: mem
            integer(c_int), value :: lenmem
            type(c_ptr) :: kiss_fft_cfg
        end function kiss_fft_alloc
        subroutine kiss_fft(kiss_fft_cfg, fin, fout) bind(c, name="kiss_fft")
            import :: kiss_fft_cpx, c_ptr
            type(c_ptr), value :: kiss_fft_cfg
            type(kiss_fft_cpx), dimension(*), intent(inout) :: fin, fout
        end subroutine kiss_fft
        function kiss_fftnd_alloc(dims, ndims, inverse_fft, mem, lenmem) bind(c, name="kiss_fftnd_alloc") result(kiss_fft_cfg)
            import
            integer(c_int), dimension(*), intent(in) :: dims
            integer(c_int), value :: ndims
            integer(c_int), value :: inverse_fft
            type(c_ptr), value :: mem
            integer(c_int), value :: lenmem
            type(c_ptr) :: kiss_fft_cfg
        end function kiss_fftnd_alloc
        subroutine kiss_fftnd(kiss_fft_cfg, fin, fout) bind(c, name="kiss_fftnd")
            import :: kiss_fft_cpx, c_ptr
            type(c_ptr), value :: kiss_fft_cfg
            type(kiss_fft_cpx), dimension(*), intent(inout) :: fin, fout
        end subroutine kiss_fftnd
        subroutine kiss_fft_free(kiss_fft_cfg) bind(c, name="free")
            import
            type(c_ptr), value :: kiss_fft_cfg
        end subroutine kiss_fft_free
        pure module function fftshift(x) result(y)
            type(kiss_fft_cpx), dimension(:), intent(in) :: x
            type(kiss_fft_cpx), dimension(size(x)) :: y
        end function fftshift
        pure module function ifftshift(x) result(y)
            type(kiss_fft_cpx), dimension(:), intent(in) :: x
            type(kiss_fft_cpx), dimension(size(x)) :: y
        end function ifftshift
    end interface
contains
    !> 初始化
    subroutine init(self, nfft, inverse_fft)
        class(fft), intent(inout) :: self
        integer(c_int), value :: nfft
        integer(c_int), value :: inverse_fft
        self%kiss_fft_cfg = kiss_fft_alloc(nfft, inverse_fft, c_null_ptr, 0_c_int)
    end subroutine init
    !> 初始化（多维）
    subroutine init_nd(self, dims, ndims, inverse_fft)
        class(fft), intent(inout) :: self
        integer(c_int), dimension(*), intent(in) :: dims
        integer(c_int), value :: ndims
        integer(c_int), value :: inverse_fft
        self%kiss_fft_cfg = kiss_fftnd_alloc(dims, ndims, inverse_fft, c_null_ptr, 0_c_int)
    end subroutine init_nd
    !> 傅里叶变换
    subroutine perform(self, fin, fout)
        class(fft), intent(inout) :: self
        type(kiss_fft_cpx), dimension(:), intent(inout) :: fin, fout
        call kiss_fft(self%kiss_fft_cfg, fin, fout)
    end subroutine perform
    !> 傅里叶变换（多维）
    subroutine perform_nd(self, fin, fout)
        class(fft), intent(inout) :: self
        type(kiss_fft_cpx), dimension(*), intent(inout) :: fin, fout
        call kiss_fftnd(self%kiss_fft_cfg, fin, fout)
    end subroutine perform_nd
    !> 释放内存
    subroutine free(self)
        class(fft), intent(inout) :: self
        call kiss_fft_free(self%kiss_fft_cfg)
    end subroutine free
end module kissfft
