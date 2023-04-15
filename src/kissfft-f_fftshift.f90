submodule(kissfft) kissfft_fftshift
contains
    module procedure fftshift
        y = cshift(x, shift=-floor(0.5*size(x)))
    end procedure fftshift
    module procedure ifftshift
        y = cshift(x, shift=-ceiling(0.5*size(x)))
    end procedure ifftshift
end submodule kissfft_fftshift
