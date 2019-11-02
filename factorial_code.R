
#libraries
library(purrr)
library(microbenchmark)

#1- factorial_code.R
# R script file that contains the code implementing your classes, methods, and generics for the longitudinal dataset.
factorial_code1<- function(n)
{
  if(n == 1 || n == 0)
    return(1)
  for (i in (n-1):1) {
    n <- n * i
  }
  n
}
#testing
factorial_code1(3)
#2- factorial
factorial_code2<- function(n)
{
  ifelse(n==0, return(1),  return( n * factorial_code2(n - 1)))
}
factorial_code2(3)

#testing
factorial_code2(3)
#3- factoria3
factorial_code3<- function(n)
{
  if(n == 1 || n == 0)
    return(1)
  Reduce('*',1:n)
}
factorial_code3(3)
#testing
factorial_code2(3)

#4- factorial3
factorial_code4<- function(n)
{
  factorial(n)
}
factorial_code4(3)
# 1- Create table for memoization. Unlike in the Fibonacci example,
# 2- memoization does not make sense function calls here because
# 3- recursive factorial calls never occur more than once for a specific input value.
# 4- Therefore, efficiency is only gained when calculating factorials for 

# subsequent input values
factorial_table <- c(rep(NA, 65))

factorial_code4 <- function(x) {
  if (x == 0)
    return(1)
  if (!is.na(factorial_table)[x])
    return(factorial_table[x])
  factorial_table[x] <<- x * factorial_code4(x - 1)
  factorial_table[x]
}



# Test functions ---------------------------------------------------------------

input <- c(0, 1, 6, 11, 13,  45, 63)

# Check if all functions produce the same results. R's built-in function
# factorial() is used to compare the results
factorial(input)
map_dbl(input, factorial_code1)
map_dbl(input, factorial_code3)
map_dbl(input, factorial_code4)
map_dbl(input, factorial_code4)

# Interestingly, the factorial_code3() produces NAs fairly early because
# reduce() runs into an integer overflow in the lower second digits (here 
# starting at fact(12))


# Measure performance and create output ----------------------------------------

# Use microbenchmark and purrr package to calculate performance for different 
# input values and for ranges of input values

sink("./factorial_output.txt")

cat("====== PART 1: Performance and comparison of indivudual input values ======\n")
cat("========================  factorial functions ======================= \n\n")

# Reset lookup table for comparing purposes
factorial_table <- c(rep(NA, 65))


# Calculate and compare perforamnce of individual input values
individual_results <- map(input, ~ microbenchmark(
  factorial_code1(.),
  factorial_code2(.),
  factorial_code3(.),
  factorial_code4(.)
))

names(individual_results) <- as.character(input)
individual_results

# Calculate and compare performance of ranges of input values
# use the microbenchmark package to time the operation of these functions and provide a summary of their performance. 
# In addition to timing your functions for specific inputs, 
# make sure to show a range of inputs in order to demonstrate the timing of each function for larger inputs.
cat("====== PART 2: compare performance of ranges and timing of input values =======\n")
cat("======================== after applying defferent factorial functions ======================= \n\n")

get_benchmark <- function(x) {
  factorial_table <<- c(rep(NA, 100))
  # Sub-millisecond accurate timing of expression evaluation.
  # use the microbenchmark package to time the operation
  microbenchmark(lapply(x, factorial_code1),
                 lapply(x, factorial_code2),
                 lapply(x, factorial_code3),
                 lapply(x, factorial_code4))
}
#timing your functions for specific inputs
ranges <- list(`range 1:10` = 1:10,
               `range 1:50` = 1:50,
               `range 1:100` = 1:100)

range_results <- map(ranges, get_benchmark)
# show a range of inputs in order to demonstrate the timing of each function
range_results
#Send R Output to a File
sink()
