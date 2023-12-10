# Util functions
include("./functions.jl")

# Load data file
data = read_data("day1")

# functions

numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

get_int = function(digit, numbers=numbers)
    if length(digit)==1
        return(digit)
    else
        return(findall(x->x==digit, numbers)[1])
    end
end

get_number = function(calibration_value, regex_condition::String)
    occurences = findall(Regex(regex_condition), calibration_value, overlap=true)
    first = calibration_value[occurences[begin]]
    first = get_int(first)
    last = calibration_value[occurences[end]]
    last = get_int(last)
    return(parse(Int64, string(first, last)))
end

get_calibration_values = function(document::String, regex_condition::String)
    lines = split(document, "\r\n")
    collection = map(get_number, lines, repeat([regex_condition], length(lines)))
    return(collection)
end

# Task 1:
calibration_values = get_calibration_values(data, "[0-9]")
println(sum(calibration_values))


# Task 2:
new_regex = string("[0-9]|", join(numbers, "|"))
calibration_values2 = get_calibration_values(data, new_regex)
println(sum(calibration_values2))