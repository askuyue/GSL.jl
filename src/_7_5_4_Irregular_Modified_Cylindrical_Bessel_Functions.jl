#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
#########################################################
# 7.5.4 Irregular Modified Cylindrical Bessel Functions #
#########################################################
export sf_bessel_K0, sf_bessel_K0_e, sf_bessel_K1, sf_bessel_K1_e,
       sf_bessel_Kn, sf_bessel_Kn_e, sf_bessel_Kn_array, sf_bessel_K0_scaled,
       sf_bessel_K0_scaled_e, sf_bessel_K1_scaled, sf_bessel_K1_scaled_e,
       sf_bessel_Kn_scaled, sf_bessel_Kn_scaled_e, sf_bessel_Kn_scaled_array


# These routines compute the irregular modified cylindrical Bessel function of
# zeroth order, K_0(x), for x > 0.
# 
#   Returns: Cdouble
function sf_bessel_K0(x::Real)
    ccall( (:gsl_sf_bessel_K0, :libgsl), Cdouble, (Cdouble, ), x )
end
@vectorize_1arg Number sf_bessel_K0


# These routines compute the irregular modified cylindrical Bessel function of
# zeroth order, K_0(x), for x > 0.
# 
#   Returns: Cint
function sf_bessel_K0_e(x::Real)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    errno = ccall( (:gsl_sf_bessel_K0_e, :libgsl), Cint, (Cdouble,
        Ptr{gsl_sf_result}), x, result )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(result)
end
@vectorize_1arg Number sf_bessel_K0_e


# These routines compute the irregular modified cylindrical Bessel function of
# first order, K_1(x), for x > 0.
# 
#   Returns: Cdouble
function sf_bessel_K1(x::Real)
    ccall( (:gsl_sf_bessel_K1, :libgsl), Cdouble, (Cdouble, ), x )
end
@vectorize_1arg Number sf_bessel_K1


# These routines compute the irregular modified cylindrical Bessel function of
# first order, K_1(x), for x > 0.
# 
#   Returns: Cint
function sf_bessel_K1_e(x::Real)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    errno = ccall( (:gsl_sf_bessel_K1_e, :libgsl), Cint, (Cdouble,
        Ptr{gsl_sf_result}), x, result )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(result)
end
@vectorize_1arg Number sf_bessel_K1_e


# These routines compute the irregular modified cylindrical Bessel function of
# order n, K_n(x), for x > 0.
# 
#   Returns: Cdouble
function sf_bessel_Kn(n::Integer, x::Real)
    ccall( (:gsl_sf_bessel_Kn, :libgsl), Cdouble, (Cint, Cdouble), n, x )
end
@vectorize_2arg Number sf_bessel_Kn


# These routines compute the irregular modified cylindrical Bessel function of
# order n, K_n(x), for x > 0.
# 
#   Returns: Cint
function sf_bessel_Kn_e(n::Integer, x::Real)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    errno = ccall( (:gsl_sf_bessel_Kn_e, :libgsl), Cint, (Cint, Cdouble,
        Ptr{gsl_sf_result}), n, x, result )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(result)
end
@vectorize_2arg Number sf_bessel_Kn_e


# This routine computes the values of the irregular modified cylindrical Bessel
# functions K_n(x) for n from nmin to nmax inclusive, storing the results in
# the array result_array. The start of the range nmin must be positive or zero.
# The domain of the function is x>0. The values are computed using recurrence
# relations for efficiency, and therefore may differ slightly from the exact
# values.
# 
#   Returns: Cint
function sf_bessel_Kn_array(nmin::Integer, nmax::Integer, x::Real)
    result_array = Array(Cdouble, 1)
    errno = ccall( (:gsl_sf_bessel_Kn_array, :libgsl), Cint, (Cint, Cint,
        Cdouble, Cdouble), nmin, nmax, x, result_array )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(result_array)[1]
end
#TODO This vectorization macro is not implemented
#@vectorize_3arg Number sf_bessel_Kn_array


# These routines compute the scaled irregular modified cylindrical Bessel
# function of zeroth order \exp(x) K_0(x) for x>0.
# 
#   Returns: Cdouble
function sf_bessel_K0_scaled(x::Real)
    ccall( (:gsl_sf_bessel_K0_scaled, :libgsl), Cdouble, (Cdouble, ), x )
end
@vectorize_1arg Number sf_bessel_K0_scaled


# These routines compute the scaled irregular modified cylindrical Bessel
# function of zeroth order \exp(x) K_0(x) for x>0.
# 
#   Returns: Cint
function sf_bessel_K0_scaled_e(x::Real)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    errno = ccall( (:gsl_sf_bessel_K0_scaled_e, :libgsl), Cint, (Cdouble,
        Ptr{gsl_sf_result}), x, result )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(result)
end
@vectorize_1arg Number sf_bessel_K0_scaled_e


# These routines compute the scaled irregular modified cylindrical Bessel
# function of first order \exp(x) K_1(x) for x>0.
# 
#   Returns: Cdouble
function sf_bessel_K1_scaled(x::Real)
    ccall( (:gsl_sf_bessel_K1_scaled, :libgsl), Cdouble, (Cdouble, ), x )
end
@vectorize_1arg Number sf_bessel_K1_scaled


# These routines compute the scaled irregular modified cylindrical Bessel
# function of first order \exp(x) K_1(x) for x>0.
# 
#   Returns: Cint
function sf_bessel_K1_scaled_e(x::Real)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    errno = ccall( (:gsl_sf_bessel_K1_scaled_e, :libgsl), Cint, (Cdouble,
        Ptr{gsl_sf_result}), x, result )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(result)
end
@vectorize_1arg Number sf_bessel_K1_scaled_e


# These routines compute the scaled irregular modified cylindrical Bessel
# function of order n, \exp(x) K_n(x), for x>0.
# 
#   Returns: Cdouble
function sf_bessel_Kn_scaled(n::Integer, x::Real)
    ccall( (:gsl_sf_bessel_Kn_scaled, :libgsl), Cdouble, (Cint, Cdouble),
        n, x )
end
@vectorize_2arg Number sf_bessel_Kn_scaled


# These routines compute the scaled irregular modified cylindrical Bessel
# function of order n, \exp(x) K_n(x), for x>0.
# 
#   Returns: Cint
function sf_bessel_Kn_scaled_e(n::Integer, x::Real)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    errno = ccall( (:gsl_sf_bessel_Kn_scaled_e, :libgsl), Cint, (Cint,
        Cdouble, Ptr{gsl_sf_result}), n, x, result )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(result)
end
@vectorize_2arg Number sf_bessel_Kn_scaled_e


# This routine computes the values of the scaled irregular cylindrical Bessel
# functions \exp(x) K_n(x) for n from nmin to nmax inclusive, storing the
# results in the array result_array. The start of the range nmin must be
# positive or zero.  The domain of the function is x>0. The values are computed
# using recurrence relations for efficiency, and therefore may differ slightly
# from the exact values.
# 
#   Returns: Cint
function sf_bessel_Kn_scaled_array(nmin::Integer, nmax::Integer, x::Real)
    result_array = Array(Cdouble, 1)
    errno = ccall( (:gsl_sf_bessel_Kn_scaled_array, :libgsl), Cint, (Cint,
        Cint, Cdouble, Cdouble), nmin, nmax, x, result_array )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_load(result_array)[1]
end
#TODO This vectorization macro is not implemented
#@vectorize_3arg Number sf_bessel_Kn_scaled_array
