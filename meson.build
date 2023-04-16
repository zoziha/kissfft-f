project(
    'kissfft-f',
    'fortran',
    version: '2.0.0',
    license: 'BSD-3',
    meson_version: '>= 0.50.0',
    default_options: [
        'buildtype=debugoptimized',
        'fortran_std=f2008',
        'default_library=both',
    ],
)
kissfft_dep = subproject('kissfft').get_variable('kissfft_dep')
kissfft_f_src_filenames = []
kissfft_f_src = files()
subdir('src')
kissfft_f_lib = library(
    meson.project_name(),
    kissfft_f_src,
    version: meson.project_version(),
    dependencies: kissfft_dep,
    install: true,
)
kissfft_f_inc = kissfft_f_lib.private_dir_include()
kissfft_f_dep = declare_dependency(
    include_directories: kissfft_f_inc,
    link_with: kissfft_f_lib,
)
example_fft = executable(
    'fft', 
    'example/fft.f90', 
    dependencies: [
        kissfft_f_dep,
    ],
)
example_ifft = executable(
    'ifft',
    'example/ifft.f90',
    dependencies: [
        kissfft_f_dep,
    ],
)
example_fft2 = executable(
    'fft2',
    'example/fft2.f90',
    dependencies: [
        kissfft_f_dep,
    ],
)
kissfft_f_lic = files(
    'LICENSE',
)
install_data(
    kissfft_f_lic,
    install_dir: join_paths(get_option('prefix'), 'share', 'licenses', meson.project_name()),
)
if host_machine.system() == 'windows'
    symbols_file = 'lib'+meson.project_name()+'-'+meson.project_version().split('.')[0]+'.dll.symbols'
    obj_suffix = '.obj'
else
    symbols_file = 'lib'+meson.project_name()+'.so.'+meson.project_version()+'.symbols'
    obj_suffix = '.o'
endif
kissfft_f_obj = []
foreach source: kissfft_f_src_filenames
    kissfft_f_obj += 'src_'+source+obj_suffix
endforeach
install_subdir(kissfft_f_lib.path()+'.p',
    install_dir: 'include'/meson.project_name(),
    strip_directory: true,
    exclude_files: [
        'depscan.dd',
        meson.project_name()+'-deps.json',
        symbols_file,
        meson.project_name()+'.dat',
        kissfft_f_obj,
    ]
)
pkg = import('pkgconfig')
pkg.generate(
    name: meson.project_name(),
    description: 'KissFFT wrapper for Fortran',
    version: meson.project_version(),
    libraries: [kissfft_f_lib],
    requires: 'kissfft',
    subdirs: meson.project_name(),
)
