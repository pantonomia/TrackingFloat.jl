using LinearAlgebra
using Test
using TrackingFloat
import Base: +, *, -, / , promote, promote_rule, sqrt, qr, <, cholesky, zero 

#test basic operators for our new type

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
value.(vt) 
v - value.(vt) 
@test maximum(abs, v - value.(vt)) < sqrt(eps()) 

# Is promotion working?
@test TrackingFloat(1.0, 0) + 2.0 == TrackingFloat(3, 2) 

#solve linear system with backsolve with your TrackingFloat
AA = A*A' 
AAt = TrackingFloat.(AA) 
sol1 = AAt.\bt
value.(sol1)
@test maximum(abs, value.(sol1) - AA.\b) < sqrt(eps())

# Try cholesky factorization
F = cholesky(value.(AAt)) 
sol2 = TrackingFloat.(F\value.(bt))
@test maximum(abs, value.(sol2) - AA\b) < sqrt(eps())

# Which method was able to work with smallest elements?
getmax.(sol1)
getmax.(sol2)






