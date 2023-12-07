include("tools.jl")

function ex1()
    inputLines = split(readFile("day1"), "\n")
    return calculateLineSums(inputLines)
end

function ex2()
    inputString = readFile("day1")
    inputLines = split(inputString, "\n")
    replacedInputLines = []
    for line in inputLines
        push!(replacedInputLines, replaceDigits(line))
    end
    return (calculateLineSums(replacedInputLines))
end

function calculateLineSums(inputLines)
    sum = 0
    for line in inputLines
        filtered = filter!(x -> isdigit(x), collect(line))
        sum += 10 * toInt(first(filtered)) + toInt(last(filtered))
    end
    return (sum)
end
















# I just had a stroke, this is my code. Please don't look.
function replaceDigits(inputString)
    x = replace(inputString, "eightwo" => "82")
    x = replace(x, "oneight" => "18")
    x = replace(x, "twone" => "21")
    x = replace(x, "one" => "1")
    x = replace(x, "two" => "2")
    x = replace(x, "three" => "3")
    x = replace(x, "four" => "4")
    x = replace(x, "five" => "5")
    x = replace(x, "six" => "6")
    x = replace(x, "seven" => "7")
    x = replace(x, "eight" => "8")
    x = replace(x, "nine" => "9")
    return (x)
end