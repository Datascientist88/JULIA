a1=[1,2,3,4,5,6]
println(a1)
a2=[1,3.5,7]
typeof(a2) #(alias for Array{Float64, 1})
a3=[println,printstyled,print]
typeof(a3) #(alias for Array{Function, 1})
a4=["I","love","Julia"]
typeof(a4) #(alias for Array{String, 1})
a5=["love",3,2.5]
typeof(a5) #(alias for Array{Any, 1})
#type declaration
a6=Int64[4,5,7]
typeof(a6) #(alias for Array{Int64, 1})
#multidiminional Array
a7=[1 3 5 ;6 7 8] 
#(alias for Array{Int64, 2})
typeof(a7)
println(a7)
#creating vector
vector2=[ 2 4 6 8]
rand1=rand(9)
println(rand1)

# looping through random integrs and mutliplying by 1000
for i in rand1
    i *= 1000 
    println(i)
end
#multidiminional Array
rand2=rand(5,6)
println(rand2)
#index 
println(a2[1])