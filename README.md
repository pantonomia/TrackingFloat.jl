# TrackingFloats

[![Build Status](https://github.com/JuliaControl/TrackingFloats.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaControl/TrackingFloats.jl/actions/workflows/CI.yml?query=branch%3Amain)

This package implements a new type of float that remembers the biggest number it has seen. It keeps two fields, one Float64 that acts as a normal float under all the specified operations in src, and one field that keeps track of the largest number (in absolute value) that has been involved in generating this TrackingFloat.
