#= they are many array methods I would like to cover here in this lesson  =#
#1- push ! method used to add elements to the end of the array :
arr1=[1,2,3]
push!(arr1,6)
println(arr1)
arrg=[]
for i in 1:50
    iseven(i) ? push!(arrg,i) : ""
end 
println(arrg)
jul=[push!(arrg,i) for i in 1:50 if iseven(i)]
println(jul)
#2- pop ! removes the last element of the array and returns it 
pop!(arr1)
println(arr1)
#3-  append ! adds all the elements from one array to the end of another 
arr2=[7,8,90]
y=append!(arr1,arr2)
println(y)
#4- insert ! inserts an element at specified position in the array 
#insert!(a::Vector, index::Integer, item)
#= Insert an item into a at the given index. index is the index of item in the resulting a.

See also: push!, replace, popat!, splice!.

Examples
julia> insert!(Any[1:6;], 3, "here")
7-element Vector{Any}:
 1
 2
  "here"
 3
 4 =#
j=insert!(arr2,3,23)
println(j)
#5-deleteat ! removes an element at a specified index
arr=[6,88,45]
z=deleteat!(arr,1) # the first element will be deleted
println(z)
#6 - sort ! sorts an arry in place
a=[3,9,1,15,55,2,7]
sorted_arr=sort!(a)
println(sorted_arr)
b=[0.6,1.3,1.77,0.11,0.05,5]
sorted_arr_floats=sort!(b)
println(sorted_arr_floats)
c=["a","f","c","b","d","g","e"]
sorted_strings=sort!(c)
println(sorted_strings)
#7- reverse ! reverses the order of the elements within the array
d=[1,2,3,4,5,6,7,8]
reversed=reverse!(d)
println(reversed)
# 8- fill ! fills the array with specified value 
arr=[0,0,0]
e=fill!(arr,6)
println(e)
# 9 copy creates a shadow copy of an array 
arr=copy(d)
println(arr)
# 10 hcat and vcat concatenates arrays horizontally and vertically 
vec1=[1,2]
vec2=[3,4]
horizonatal_concat=hcat(vec1,vec2)
println(horizonatal_concat)
vertical_concat=vcat(vec1,vec2)
println(vertical_concat)
# 11- reshape changes the shape of the array without changing its data
arr=[5,7,9,10]
reshaped=reshape(arr,2,2)
println(reshaped)

#= reshape(A, dims...) -> AbstractArray
reshape(A, dims) -> AbstractArray
Return an array with the same data as A, but with different dimension sizes or number of dimensions. 
The two arrays share the same underlying data, so that the result is mutable if and only if A is mutable, and setting elements of one alters the values of the other.

The new dimensions may be specified either as a 
list of arguments or as a shape tuple. 
At most one dimension may be specified with a :, 
in which case its length is computed such that its product with all the specified dimensions is equal to the length of the original array A. The total number of elements must not change. =#

#12 findall finds all indices where a condition is True
arr=[1,28,3,16,5,6,7,82]
indices=findall(x -> x %2 ==0, arr)
println(indices)
# array comprehension to extract the exact items
nums=[arr[index] for index in indices]
println(nums)

#13- filter : returns a new array with elements that satisfied a condition 
filtered=filter(x -> x > 7, arr)
println(filtered)

# map : applies function to each element of the array
arr=[5,7,9,11,45]
mapped=map(x -> x^4 ,arr)
println(mapped)

function powered60th(e::Int)
    r=e^60
    return r
end
mapped2=map(powered60th,arr)
println(mapped2)

arr=[34,67,25,40,30,46,88,777]
function methodmulitplies(n::Int)
    result=n%2==0 ? n÷2 : n *0
    result
end
mapped3=map(methodmulitplies,arr)
println(mapped3)

# Reduce reduces the array to a single value 
#reduce(op, itr; [init])
#= Reduce the given collection itr with the given binary operator op. If provided, 
the initial value init must be a neutral element for op that will be returned for empty collections.
 It is unspecified whether init is used for non-empty collections.

For empty collections, providing init will be necessary, except for some special cases
 (e.g. when op is one of +, *, max, min, &, |) when Julia can determine the neutral element of op.
Reductions for certain commonly-used operators may have special implementations, 
and should be used instead: maximum(itr), minimum(itr), sum(itr), prod(itr), any(itr), 
all(itr). There are efficient methods for concatenating certain arrays of arrays by calling reduce(vcat, arr) or reduce(hcat, arr).
The associativity of the reduction is implementation dependent. This means that you can't use non-associative operations like - because it is undefined whether reduce(-,[1,2,3]) should be evaluated as (1- =#
multiply=reduce(*,arr)
println(multiply)
sum=reduce(+,arr)
println(sum)
subtract=reduce(-,arr)
println(subtract)
Max=reduce(max,arr)
println(Max)
Min=reduce(min,arr)
println(Min)
div=reduce(÷,arr)
println(div)

#!6 collect 
arr=collect(1:2:100)
arr3=collect(1:200)
println(arr)
arr1=reverse!(arr)
println(arr1)
# find the array of the odd numbers in arr3:
array_odd=[x for x in arr3 if isodd(x)]
println(array_odd)
# find the array of the even numbers in arr3:
array_even=[x for x in arr3 if iseven(x)]
println(array_even)
#array even numbers:
array_even2=[x for x in arr3 if x%2==0]
println(array_even2)
method_check=array_even==array_even2 ? "The two methods yield the same result" : "The two methods are different"
println(method_check)
findal=findall(x -> x > 6, arr) # return the indices
fiter=filter(x -> x >6,arr) # return the array  based on a condition
println(findal)
println(fiter)
#17 unique returns an array without duplicates
arr9=[5,5,7,7,1,9,4]
uniq=unique(arr9)
println(uniq)

#18 broadcast very much like map applies a function to each element of the array 
broadcasted=broadcast(x-> x^2 +1 , arr)
println(broadcasted)
function findsqrt(x::Int)
    if (x %2)== 0
      √x
    else x ÷ 2
    end
end 
broadcaster=broadcast(x -> findsqrt(x), arr)
println(broadcaster)
# 19 folder right fold of the element 
arry=[1,2,3,4,5,6,7,8,9,10,11,12]
folded=foldr(*,arry)
println(folded)
folded1=foldr(+,arry)
println(folded1)
folded3=reduce(*,arry)
println(folded3)
println(folded3==folded)