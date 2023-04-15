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

kissfft 在 Windows-MSYS2/Ubuntu 均有仓库二进制文件，省去了编译过程，而 BLAS 和 FFT 是如此重要，所以撰写了 kissfft-f。
[fffc](ttps://gitee.com/ship-stack/fffc) 中基于 OpenBLAS 对线性代数进行了封装，而 kissfft-f 则基于 kissfft 对 FFT 进行了封装。

@warning
kissfft-f 仅支持单精度浮点数。
