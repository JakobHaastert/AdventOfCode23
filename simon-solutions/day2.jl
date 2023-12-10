# Util functions
include("functions.jl")

# packages
using Dictionaries

# Load data file
data = read_data("day2")

# functions
make_cube_dict = function(game::SubString)
    colors = ["red", "green", "blue"]
    dict = Dict()
    for col in colors
        index = first.(findall(col, game)) .- 3
        dict[col] = parse.(Int, SubString.(game, index, index.+1))
    end
    return dict
end

get_games = function(record::String)
    games = split(record, "\r\n")
    games_dict = map(make_cube_dict, games)
    return games_dict
end

is_possible = function(game::Dict, max_cubes::Dict)
    hi = 0
    for (k, v) in game
        hi += sum(v .> max_cubes[k])
    end
    possible = hi==0
    return possible
end

get_power = function(game::Dict)
    power = 1
    for (_, v) in game
        power *= maximum(v)
    end
    return power
end

# Get games in dict format
games = get_games(data)
max_cubes = Dict([("red", 12), ("green", 13), ("blue", 14)])

# Calculate the sum of ids
gameid_sum = 0
for (i, v) in enumerate(games)
   global gameid_sum += i * is_possible(v, max_cubes) 
end
print(gameid_sum)

# Calculate sum of powers
sum(get_power.(games))