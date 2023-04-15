project(
    'kissfft-f',
    'fortran',
    version: '1.0.0',
    license: 'BSD-3',
    meson_version: '>= 0.50.0',
    default_options: [
        'buildtype=debugoptimized',
        'fortran_std=f2008',
    ],
)
kissfft_f_src = files(
    'src/kissfft-f.f90',
)
kissfft_f_lib = library(
    meson.project_name(),
    kissfft_f_src,
    version: meson.project_version(),
    link_args: '-lkissfft',
    install: true,
)
kissfft_f_inc = kissfft_f_lib.private_dir_include()
kissfft_f_dep = declare_dependency(
    include_directories: kissfft_f_inc,
    link_with: kissfft_f_lib,
)
example_demo = executable('demo', 'example/demo.f90', dependencies: kissfft_f_dep)
kissfft_f_lic = files(
    'LICENSE',
)
install_data(
    kissfft_f_lic,
    install_dir: join_paths(get_option('prefix'), 'share', 'licenses', meson.project_name()),
)
pkg = import('pkgconfig')
pkg.generate(
    name: meson.project_name(),
    description: 'KissFFT wrapper for Fortran',
    version: meson.project_version(),
    libraries: [kissfft_f_lib, '-lkissfft'],
    install_dir: join_paths(get_option('prefix'), 'lib', 'pkgconfig'),
)
