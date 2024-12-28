# square of the sum of first n positive numbers
function square_of_sum(n)
    #= sum=0
    for i in 1: n 
        sum += i
    end
    sum^2 =#
    # simplify it a bit 
    #= sum_of_n=sum(1:n)
    sum_of_n^2 =#
   # sum(1:n)^2
   # use math formula for that 
   ((n^2 +n)÷ 2)^2
   # use array commprehension
   #sum_of_n=(sum([x for x in 1:n]))^2
   #sum_of_n
end
# sum of the squares of the first n positive numbers
function sum_of_squares(n)
   #=  sum=0
    for i in 1: n 
        sum +=i^2
    end
    sum =#
    # you can simplify
    #sum(x -> x^2 , 0:n)
    # simplyfied math formula 
    #(n*(n+1)*(2n+1))÷ 6
    sum([x^2 for x in 1:n])
end
# subtract the sum of squares from the square sum 
function difference(n)
    square_of_sum(n)-sum_of_squares(n)
    
end

println(difference(20))