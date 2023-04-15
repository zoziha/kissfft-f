# kissfft-f

kissfft 是一款基于 BSD-3 协议的快速傅里叶变换库，kissfft-f 是 kissfft 的 Fortran 封装，基本满足日常的 FFT 需求。

kissfft 在 Windows-MSYS2/Ubuntu 均有仓库二进制文件，省去了编译过程，而 BLAS 和 FFT 是如此重要，所以撰写了 kissfft-f。
[fffc](ttps://gitee.com/ship-stack/fffc) 中基于 OpenBLAS 对线性代数进行了封装，而 kissfft-f 则基于 kissfft 对 FFT 进行了封装。

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
    call fft_obj%free()
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
    call fft_obj%free()
end program main
!  4.00000000       0.00000000
!  8.00000000       0.00000000
!  12.0000000       0.00000000
!  16.0000000       0.00000000
```
