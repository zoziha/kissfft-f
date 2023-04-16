project(
    'kissfft',
    'c',
    license: 'BSD-3',
    meson_version: '>= 0.50.0',
    version: '131.1.1',
    default_options: [
        'buildtype=debugoptimized',
        'default_library=both',
    ],
)
kissfft_src = files(
    'src/kfc.c',
    'src/kiss_fft.c',
    'src/kiss_fftr.c',
    'src/kiss_fftnd.c',
    'src/kiss_fftndr.c',
)
kissfft_inc = include_directories('include')
kissfft_lib = library(
    meson.project_name(),
    kissfft_src,
    include_directories: kissfft_inc,
    version: meson.project_version(),
    dependencies: dependency('openmp'),
    install: true,
)
kissfft_dep = declare_dependency(
    include_directories: kissfft_inc,
    link_with: kissfft_lib,
)
kissfft_lic = files(
    'COPYING',
    'LICENSES/BSD-3-Clause',
    'LICENSES/Unlicense',
)
install_data(
    kissfft_lic,
    install_dir: join_paths(get_option('prefix'), 'share', 'licenses', meson.project_name()),
)
install_headers(
    'include/_kiss_fft_guts.h',
    'include/kfc.h',
    'include/kiss_fft.h',
    'include/kiss_fft_log.h',
    'include/kiss_fftnd.h',
    'include/kiss_fftr.h',
    'include/kiss_fftndr.h',
    'include/kiss_fftr.h',
    'include/kissfft_i32.hh',
    'include/kissfft.hh',
    install_dir: join_paths(get_option('prefix'), 'include', meson.project_name()),
)
pkg = import('pkgconfig')
pkg.generate(
    name: meson.project_name(),
    description: 'A Fast Fourier Transform based up on the principle: Keep It Simple, Stupid',
    version: meson.project_version(),
    libraries: kissfft_lib,
    subdirs: meson.project_name(),
)
