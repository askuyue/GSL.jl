#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
################################
# 7.7.2 Coulomb Wave Functions #
################################
export sf_coulomb_wave_FG_e, sf_coulomb_wave_F_array, sf_coulomb_wave_FG_array,
       sf_coulomb_wave_FGp_array, sf_coulomb_wave_sphF_array




# This function computes the Coulomb wave functions F_L(\eta,x),
# G_{L-k}(\eta,x) and their derivatives F'_L(\eta,x),  G'_{L-k}(\eta,x) with
# respect to x.  The parameters are restricted to L, L-k > -1/2, x > 0 and
# integer k.  Note that L itself is not restricted to being an integer. The
# results are stored in the parameters F, G for the function values and Fp, Gp
# for the derivative values.  If an overflow occurs, GSL_EOVRFLW is returned
# and scaling exponents are stored in the modifiable parameters exp_F, exp_G.
# 
#   Returns: Cint
function sf_coulomb_wave_FG_e(eta::Real, x::Real, L_F::Real, k::Integer)
    F = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    Fp = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    G = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    Gp = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    exp_F = convert(Ptr{Cdouble}, Array(Cdouble, 1))
    exp_G = convert(Ptr{Cdouble}, Array(Cdouble, 1))
    errno = ccall( (:gsl_sf_coulomb_wave_FG_e, :libgsl), Cint, (Cdouble,
        Cdouble, Cdouble, Cint, Ptr{gsl_sf_result}, Ptr{gsl_sf_result},
        Ptr{gsl_sf_result}, Ptr{gsl_sf_result}, Ptr{Cdouble}, Ptr{Cdouble}),
        eta, x, L_F, k, F, Fp, G, Gp, exp_F, exp_G )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(F), unsafe_load(Fp), unsafe_load(G), unsafe_load(Gp), unsafe_load(exp_F), unsafe_load(exp_G)
end
#TODO This vectorization macro is not implemented
#@vectorize_4arg Number sf_coulomb_wave_FG_e


# This function computes the Coulomb wave function F_L(\eta,x) for L = Lmin
# \dots Lmin + kmax, storing the results in fc_array.  In the case of overflow
# the exponent is stored in F_exponent.
# 
#   Returns: Cint
function sf_coulomb_wave_F_array(L_min::Real, kmax::Integer, eta::Real, x::Real, fc_array::Real)
    errno = ccall( (:gsl_sf_coulomb_wave_F_array, :libgsl), Cint, (Cdouble,
        Cint, Cdouble, Cdouble, Cdouble), L_min, kmax, eta, x, fc_array )
    if errno!= 0 throw(GSL_ERROR(errno)) end
end
#TODO This vectorization macro is not implemented
#@vectorize_5arg Number sf_coulomb_wave_F_array


# This function computes the functions F_L(\eta,x), G_L(\eta,x) for L = Lmin
# \dots Lmin + kmax storing the results in fc_array and gc_array.  In the case
# of overflow the exponents are stored in F_exponent and G_exponent.
# 
#   Returns: Cint
function sf_coulomb_wave_FG_array(L_min::Real, kmax::Integer, eta::Real, x::Real, fc_array::Real)
    errno = ccall( (:gsl_sf_coulomb_wave_FG_array, :libgsl), Cint,
        (Cdouble, Cint, Cdouble, Cdouble, Cdouble), L_min, kmax, eta, x,
        fc_array )
    if errno!= 0 throw(GSL_ERROR(errno)) end
end
#TODO This vectorization macro is not implemented
#@vectorize_5arg Number sf_coulomb_wave_FG_array


# This function computes the functions F_L(\eta,x), G_L(\eta,x) and their
# derivatives F'_L(\eta,x), G'_L(\eta,x) for L = Lmin \dots Lmin + kmax storing
# the results in fc_array, gc_array, fcp_array and gcp_array.  In the case of
# overflow the exponents are stored in F_exponent and G_exponent.
# 
#   Returns: Cint
function sf_coulomb_wave_FGp_array(L_min::Real, kmax::Integer, eta::Real, x::Real, fc_array::Real)
    errno = ccall( (:gsl_sf_coulomb_wave_FGp_array, :libgsl), Cint,
        (Cdouble, Cint, Cdouble, Cdouble, Cdouble), L_min, kmax, eta, x,
        fc_array )
    if errno!= 0 throw(GSL_ERROR(errno)) end
end
#TODO This vectorization macro is not implemented
#@vectorize_5arg Number sf_coulomb_wave_FGp_array


# This function computes the Coulomb wave function divided by the argument
# F_L(\eta, x)/x for L = Lmin \dots Lmin + kmax, storing the results in
# fc_array.  In the case of overflow the exponent is stored in F_exponent. This
# function reduces to spherical Bessel functions in the limit \eta \to 0.
# 
#   Returns: Cint
function sf_coulomb_wave_sphF_array(L_min::Real, kmax::Integer, eta::Real, x::Real, fc_array::Real)
    errno = ccall( (:gsl_sf_coulomb_wave_sphF_array, :libgsl), Cint,
        (Cdouble, Cint, Cdouble, Cdouble, Cdouble), L_min, kmax, eta, x,
        fc_array )
    if errno!= 0 throw(GSL_ERROR(errno)) end
end
#TODO This vectorization macro is not implemented
#@vectorize_5arg Number sf_coulomb_wave_sphF_array
