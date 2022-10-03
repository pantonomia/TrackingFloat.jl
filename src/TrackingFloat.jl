module TrackingFloats

export TrackingFloat

using LinearAlgebra

import Base: +, *, -, / , promote, promote_rule, sqrt, qr, <, cholesky, zero

struct TrackingFloat <: AbstractFloat
    new :: Float64
    big :: Float64
end 
 

#Constructor
aux = 0.0 
TrackingFloat() = TrackingFloat(aux, aux) 
TrackingFloat(x) = TrackingFloat(x, aux)  
TrackingFloat(v::TrackingFloat) = v

#Basic methods +, -, *, /

function +(v1::TrackingFloat, v2::TrackingFloat)
    a = v1.new + v2.new
    b = max(abs(v1.new), abs(v2.new),abs(v1.big), abs(v2.big))
    return TrackingFloat(a,b)
end

function -(v1::TrackingFloat, v2::TrackingFloat)
    a = v1.new-v2.new
    b = max(abs(v1.new), abs(v2.new),abs(v1.big), abs(v2.big))
    return TrackingFloat(a,b)
end

function *(v1::TrackingFloat, v2::TrackingFloat)
    a = v1.new*v2.new
    b = max(abs(v1.new), abs(v2.new),abs(v1.big), abs(v2.big))
    return TrackingFloat(a,b)
end

function /(v1::TrackingFloat, v2::TrackingFloat)
    a = v1.new / v2.new
    if v2.new > 1.0
        b = max(abs(v1.new), abs(v2.new),abs(v1.big), abs(v2.big))
    else
        b = max(abs(v1.new), 1/abs(v2.new),abs(v1.big), abs(v2.big))
    end
    return TrackingFloat(a,b)
end

#Basic methods 2 sqrt, <, -a, abs 

function sqrt(v::TrackingFloat)
    root = sqrt(v.new)
    max_val = max(abs(v.new), abs(v.big))
    return TrackingFloat(root, max_val)
end

function <(v1::TrackingFloat,v2::TrackingFloat)
    if v1.new < v2.new
        w = v1.new
    else
        w = v2.new
    return w
    end
end

function -(v::TrackingFloat)
    a = -(v.new)
    b = max(abs(v.new), abs(v.big))
    return TrackingFloat(a,b)
end

function abs(v::TrackingFloat)
    a = abs(v.new)
    b = abs(v.big)
    return TrackingFloat(a,b)
end
    
#Additional basic operations
value(v::TrackingFloat) = v.new
getmax(v::TrackingFloat) = v.big
zero(v::TrackingFloat) = TrackingFloat(0.0, 0.0)
TrackingFloat(v::TrackingFloat) = v
    
#promote rule
    
promote_rule(::Type{T}, ::Type{TrackingFloat}) where {T<:Number} = TrackingFloat
    
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
