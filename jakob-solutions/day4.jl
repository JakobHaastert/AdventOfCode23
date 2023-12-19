include("tools.jl")
input = split(readFile("day4"), "\r\n")

function processCard(line)
    numbersList = split.(split(last(split(line, ": ")), " | "), " ")
    winningNumbers = filter(x -> x != "", first(numbersList))
    numbers = filter(x -> x != "", last(numbersList))
    return length(intersect(winningNumbers, numbers))
end

function checkSingleCard(line)
    size = processCard(line)
    returnVal = size == 0 ? 0 : 2 ^ (size-1)
    return(returnVal)
end

numberOfCopies = Dict()
for i in 1:length(input)
    numberOfCopies[i] = 1
end
for (i, line) in enumerate(input)
    winningCount = processCard(line)
    for j in (i+1):(i + winningCount)
        numberOfCopies[j] += numberOfCopies[i]
    end
end

# Exercise 1
println(sum(checkSingleCard.(input)))
# Exercise 2
println(sum(values(numberOfCopies)))