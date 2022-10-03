# TrackingFloats
![Build Status](https://github.com/pantonomia/TrackingFloats.jl/actions/workflows/CI.yml/badge.svg?branch=main)
![Coverage](https://codecov.io/gh/pantonomia/TrackingFloats.jl/branch/main/graph/badge.svg)


This package hosted in github implements a new type of float that remembers the biggest number it has seen. It keeps two fields, one Float64 that acts as a normal float under all the specified operations in src, and one field that keeps track of the largest number (in absolute value) that has been involved in generating this TrackingFloat.

We exported some useful basic functions and operators for this new type such as +, -, *, /, sqrt, <, abs or the promote rule.

```julia
struct TrackingFloat <: AbstractFloat
    new :: Float64
    big :: Float64
end 

#Constructor
aux = 0.0 
TrackingFloat() = TrackingFloat(aux, aux) 
TrackingFloat(x) = TrackingFloat(x, aux)  
TrackingFloat(v::TrackingFloat) = v

```
```julia
#Basic function
function +(v1::TrackingFloat, v2::TrackingFloat)
    a = v1.new + v2.new
    b = max(abs(v1.new), abs(v2.new),abs(v1.big), abs(v2.big))
    return TrackingFloat(a,b)
end
```
```julia
#promote rule

promote_rule(::Type{T}, ::Type{TrackingFloat}) where {T<:Number} = TrackingFloat
```

We used the tests proposed in our homework from week 2 resulting on a 70,2% coverage by codecov, which means there is a 29,8% of our code not tested by the tests that where predesign.
