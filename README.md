# kissfft-f

kissfft 是一款基于 BSD-3 协议的快速傅里叶变换库，kissfft-f 是 kissfft 的 Fortran 封装，基本满足日常的 FFT 需求。

kissfft 在 Windows-MSYS2/Ubuntu 均有仓库二进制文件，但 Windows-MSYS2 中的 kissfft 不完整，
于是本库重新整理了 kissfft 的源码，以便在各操作系统中使用。
同时，本库的 kissfft 移除了 CMake/Make 支持，添加了 fpm/meson 支持，对于想使用前两者构建工具的开发者，
可前往[ kissfft 源码库](https://github.com/mborgerding/kissfft)。

## 依赖

- [kissfft](https://github.com/mborgerding/kissfft).

## 编译

使用 fpm 进行编译：

```sh
> fpm build
> fpm install --prefix=C:/msys64/mingw64
```

使用 meson 进行编译：

```sh
> meson setup _build -Dprefix=/mingw64
> meson compile -C _build
> meson install -C _build --destdir=C:/msys64
```

## 使用

在 fpm 中使用 kissfft-f：

```toml
[dependencies]
kissfft-f = { git = "https://gitee.com/fortran-stack/kissfft-f.git" }
```

在 meson 中使用 kissfft-f：

```meson
kissfft_f_dep = subproject('kissfft-f').get_variable('kissfft_f_dep')
```

并且在项目的 `subprojects` 目录中添加 kissfft-f 的子项目：

```sh
> cat subprojects/kissfft-f.wrap
[wrap-git]
directory = kissfft-f
url = https://gitee.com/fortran-stack/kissfft-f.git
revision = head
```

## 傅里叶变换示例

正向傅里叶变换，`fpm run --example fft`：

```fortran
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
    do i = 1, 4
        print *, out(i)%re, out(i)%im
    end do
end program main
!   10.0000000       0.00000000
!  -2.00000000       2.00000000
!  -2.00000000       0.00000000
!  -2.00000000      -2.00000000
```

反向傅里叶变换，`fpm run --example ifft`：

```fortran
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
```

二维傅里叶变换，`fpm run --example fft2`：

```fortran
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
```
