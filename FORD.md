---
project: kissfft-f
summary: KissFFT wrapper for Fortran
project_github: https://github.com/zoziha/kissfft-f
project_website: https://gitee.com/fortran-stack/kissfft-f/
output_dir: _build/ford
author: 左志华
author_description: 哈尔滨工程大学--船舶与海洋结构物设计制造
email: zuo.zhihua@qq.com
website: https://gitee.com/zoziha
source: true
md_extensions: markdown.extensions.toc
---

kissfft 是一款基于 BSD-3 协议的快速傅里叶变换库，kissfft-f 是 kissfft 的 Fortran 封装，基本满足日常的 FFT 需求。

kissfft 在 Windows-MSYS2/Ubuntu 均有仓库二进制文件，但 Windows-MSYS2 中的 kissfft 不完整，
于是本库重新整理了 kissfft 的源码，以便在各操作系统中使用。
同时，本库的 kissfft 移除了 CMake/Make 支持，添加了 fpm/meson 支持，对于想使用前两者构建工具的开发者，
可前往[kissfft源码库](https://github.com/mborgerding/kissfft)。

@warning
kissfft-f 仅支持单精度浮点数。
