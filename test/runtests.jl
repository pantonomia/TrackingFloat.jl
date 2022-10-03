using LinearAlgebra
using Test
using TrackingFloats

#test basic operators +, -, *, / for tracking floats
#@testset "TrackingFloats.jl" begin

v = TrackingFloat(1.0) + TrackingFloat(3.0)
  
@test v     == TrackingFloat(4,3)           # which we test using the macro @test
@test v*v   == TrackingFloat(16, 4) 
@test v - v == TrackingFloat(0, 4) 
@test v/TrackingFloat(0.1, 0) == TrackingFloat(40, 10) 

# Try working with matrices
A = randn(10,10) 
b = randn(10) 

# Convert using broadcast
At = TrackingFloat.(A) 
bt = TrackingFloat.(b) 
v = A*b 
vt = At*bt 

@test maximum(abs, v - value.(vt)) < sqrt(eps()) 

# Is promotion working?
#promote_rule(::Type{T}, ::Type{TrackingFloat}) where {T<:Number} = TrackingFloat
c = TrackingFloat(1.0, 0) 
d = 1.0
c+d
@test TrackingFloat(1.0, 0) + 2.0 == TrackingFloat(3, 2) 

#solve linear system with backsolve with your TrackingFloat
AA = A*A'  # Create Positive definite matrix
AAt = TrackingFloat.(AA) # Convert to TrackingFloat matrix

#solve linear system with backsolve with your trackingfloat
sol1 = AAt\bt
value.(sol1)
@test maximum(abs, value.(sol1) - AA\b) < sqrt(eps())

#Try cholesky factorization
F = cholesky(value.(AAt)) 
sol2 = TrackingFloat.(F\value.(bt))
@test maximum(abs, value.(sol2) - AA\b) < sqrt(eps())

#Which method was able to work with smallest elements?
getmax.(sol1)
getmax.(sol2)
  
#end





