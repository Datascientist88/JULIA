# Math functions
f(x)=x^2 +1
println(f(6))
f(x,y)=x^2 + 2*x*y + y^3
result=f(3,5)
println(result)

# functions in Julia implicite type inference
function greeting(name)
    println(string("Hello ", name))
end

# Call the function
greeting("hassan")
