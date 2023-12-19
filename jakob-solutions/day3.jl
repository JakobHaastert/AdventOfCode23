include("tools.jl")

stringList = (collect.(split(readFile("day3"), "\r\n")))
stringList = string.(mapreduce(permutedims, vcat, stringList))

# Max. 3x3 matrix surrounding the given index combination.
function partMatrix(matrix, x, y, n, m)
    lowX = x-1 < 1 ? 1 : x - 1
    highX = x + 1 > n ? n : x + 1
    lowY = y-1 < 1 ? 1 : y - 1
    highY = y + 1 > m ? m : y + 1
    return(matrix[lowX:highX, lowY:highY])
end

# Find all unique numbers in a matrix.
function allNumbersInMatrix(matrix, addOnlyConnected::Bool)
    returnList = []
    n,m = size(matrix)
    for i in 1:n
        connected = false
        numberToAdd = 0
        for j in 1:m
            currentField = tryparse(Int, matrix[i,j])
            if(currentField !== nothing)
                surroundingMatrix = partMatrix(matrix, i, j, n, m)
                connected = connected || any(occursin( r"[^0-9.]", elem) for elem in surroundingMatrix[:])
                numberToAdd = currentField
            elseif(numberToAdd != 0 && (connected || !addOnlyConnected))
                push!(returnList, numberToAdd)
                numberToAdd = 0
                connected = false
            end
        end
        if(numberToAdd != 0 && ( connected || !addOnlyConnected))
            push!(returnList, numberToAdd)
        end
    end
    return(returnList)
end

# Replace every digit with the whole number it generates with its buddies
n,m = size(stringList)
ex2Sum = 0
for i in 1:n
    tempSum = 0
    indexList = []
    for j in 1:m
        if (isdigit(first(stringList[i,j])))
            tempSum *= 10
            tempSum += parse(Int, stringList[i,j])
            push!(indexList, (i,j))
        else
            if tempSum != 0
                for (x,y) in indexList
                    stringList[x,y] = string(tempSum)
                end
                indexList = []
            end
            tempSum = 0
        end
    end
    if tempSum != 0
        for (x,y) in indexList
            stringList[x,y] = string(tempSum)
        end
    end
end

# Calculate exercise 2
ex2Sum = 0
for (i, j) in Iterators.product(1:n, 1:m)
    if(stringList[i,j] == "*")
        allSurroundingNumbers = allNumbersInMatrix(partMatrix(stringList, i, j, n, m), false)
        if(length(allSurroundingNumbers) == 2)
            global ex2Sum += first(allSurroundingNumbers) * last(allSurroundingNumbers)
        end
    end
end
ex1Sum = sum(allNumbersInMatrix(stringList, true))
println("Exercise 1: $ex1Sum \nExercise 2: $ex2Sum")