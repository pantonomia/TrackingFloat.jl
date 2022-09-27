using LinearAlgebra

import Base: +, *, -, / , promote, promote_rule, sqrt, qr, <, cholesky, zero

struct TrackingFloat <: AbstractFloat
    new :: Float64
    big :: Float64
end 
 
aux = 0.0 

#constructor
TrackingFloat() = TrackingFloat(aux, aux) 
TrackingFloat(x) = TrackingFloat(x, aux)  

#methods
suma(v1::TrackingFloat, v2::TrackingFloat) = v1.new + v2.new
mult(v1::TrackingFloat, v2::TrackingFloat) = v1.new * v2.new
resta(v1::TrackingFloat, v2::TrackingFloat) = abs(v1.new - v2.new) 
divide(v1::TrackingFloat, v2::TrackingFloat) = v1.new * (1/v2.new) 
den(v1::TrackingFloat, v2::TrackingFloat) = (1/v2.new) 
compara(v1::TrackingFloat, v2::TrackingFloat) = max(abs(v1.new), abs(v2.new), abs(v1.big), abs(v2.big))

#Operators defined for our new type
a::TrackingFloat + b::TrackingFloat = TrackingFloat(suma(a,b), compara(a,b))
a::TrackingFloat * b::TrackingFloat = TrackingFloat(mult(a,b), compara(a,b))
a::TrackingFloat - b::TrackingFloat = TrackingFloat(resta(a,b), compara(a,b)) 
a::TrackingFloat / b::TrackingFloat = TrackingFloat(divide(a,b), den(a,b))

value(v::TrackingFloat) = v.new
getmax(v::TrackingFloat) = v.big
sqrt(v::TrackingFloat) = TrackingFloat(sqrt(abs(v.new)), v.big)
zero(v::TrackingFloat) = TrackingFloat(0.0, 0.0)
TrackingFloat(v::TrackingFloat) = v
promote_rule(::Type{T}, ::Type{TrackingFloat}) where {T<:Number} = TrackingFloat

# Try working with matrices e.g.: A = randn(10,10); b = randn(10) and convert using broadcast
#At = TrackingFloat.(A) bt = TrackingFloat.(b) Try some operations e.g.: v = A*b; At; bt; vt = At*bt 
# Get the max fields using a function getmax

getmax(v::Vector{TrackingFloat}) = maximum(compara.(v,v))      #getmax.(vt)
getmax(A::Matrix{TrackingFloat}) = maximum(compara.(A,A)) 



