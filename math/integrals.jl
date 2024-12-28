 # uncomment to install dependencies
#using Pkg
#Pkg.add("QuadGK")
using QuadGK

f(x) = x^2
result, _ = quadgk(f, 0, 1)

println("The integral of x^2 from 0 to 1 is: $result")
f(x)=x^6 +5*x^2 +3*x -1
answer,_ =quadgk(f,-5,5)

println("The Integral  of x^6 +5*x^2 +3*x -1 : $answer")

#Integrate 

f(x) = sin(x)
result, _ = quadgk(f, 0, π)

println("The integral of sin(x) from 0 to π is: $result")

result, _ = quadgk(f, -3π, 3π)
# Use the integral symbol in a comment for clarity
println("The integral ∫ x² dx from -3π to 3π is: $result")

f(x)=(√abs(tan(x^3))) ÷ (x^2)
integ,_= quadgk(f,-π ,6π )
println("the integeral ∫ √tan(x^3)-2/x^2-1 dx  from -6π  to 6π is :$integ ")

f(x) = exp(-x^2)
∞=Inf
# Perform the integration over an infinite domain
integ, _ = quadgk(f, -∞, ∞)
println("The integral ∫ e^(-x^2) dx from -∞ to ∞ is: $integ")

f(x)=1/(1+x^2)
integ,_ =quadgk(f,-90,180)
println("The integral ∫ 1/(1+x^2) dx from -90 to 180 is : $integ")

f(x)=4

integ,_ =quadgk(f,-4,180)
println("The integral ∫ 4 dx from -4 to 180 is : $integ")

f(x)=sin(x)+10*(csc(x))^2
integ,_ =quadgk(f,-π,6π)
println("The integeral ∫ sin(x)+10*(csc(x))^2 dx from -π to 6π is :$integ")

f(t)= t^3 +4*t^2
integ,_ =quadgk(f,-π,6π)
println("The integeral ∫ t^3 +4*t^2 dx from -π to 6π is :$integ")

f(x) = sin(x)^2

# Perform the integration
integ, _ = quadgk(f, 0, π)

println("The integral ∫ sin^2(x) dx from 0 to π is: $integ")

f(x) = csc(x)^2

# Perform the integration
integ, _ = quadgk(f, π/6, π/3)
println("The integral ∫ csc^2(x) dx from π/6 to π/3 is: $integ")

# apply it to a set of angles
angles=[(π/6, π/3),(π,π/4),(180,360)]
# Convert any angles in degrees to radians
angles = [(deg2rad(a), deg2rad(b)) for (a, b) in angles]

# Iterate over each angle pair and calculate the integral
for (a, b) in angles
    local integ  # Declare integ as local to avoid scope warnings
    integ, _ = quadgk(f, a, b)
    println("The integral of csc(x)^2 from $a to $b is: $integ")
end

f(x)=3*x^3 + 2*x^2 + x +1
answer,_ =quadgk(f,4,8)

println("The integral ∫3x^3 + 2x^2 + x +1 is : $answer")
# apply the integration to an array of tuples 
f(x)=3*x^3 + 2*x^2 + x +1
arr=[(6,8),(15,29),(12,17),(25,34),(48,70)]

for (i,j) in arr 
    local  answer
    answer,_ =quadgk(f,i,j)
    println("The integral ∫ 3x^3 + 2x^2 + x +1 dx from $i to $j is : $answer")

end 

# using quadgk !
# Define the in-place function
function f!(y, x)
    y[1] = sin(x)
    y[2] = cos(x)
    y[3] = sin(2x)
end

# Prepare the result array to store the output of the integral
result = zeros(3)

# Integrate from 0 to π
I, E = quadgk!(f!, result, 0, π)

println("The integral result is: $I")
println("The estimated error is: $E")

a, b = 2, 1
f(x) = a * x + b
result, error = quadgk(f, 1, 3)
println("Integral result of 2x + 1 from 1 to 3: ", result)
println("Estimated error: ", error)

f(x) = 3x^2 + 2x + 1
result, error = quadgk(f, 0, 2)
println("Integral result of 3x^2 + 2x + 1 from 0 to 2: ", result)
println("Estimated error: ", error)








