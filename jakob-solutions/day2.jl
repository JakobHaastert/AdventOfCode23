include("tools.jl")

mutable struct DiceCount 
    count::Int
    color::String
end

mutable struct DiceGameRound
    sets::Vector{DiceCount}
end

mutable struct DiceGame
    id::Int
    rounds::Vector{DiceGameRound}
end

function ex1()
    games = readFile("day2")
    boolList = gameWorks.(stringToGameSet(games),12,13,14)
    print(calculateIdSum(boolList))
end

function ex2()
    games = readFile("day2")
    flatRoundGames = flattenGame.(stringToGameSet(games))
    print(sum(getMinDiceNumberPower.(flatRoundGames)))
end

function getMinDiceNumberPower(diceCounts::Vector{DiceCount})
    red = -1
    green = -1
    blue = -1
    for dice in diceCounts
        col = dice.color
        count = dice.count
        if col == "red" && count > red
            red = count
        elseif col == "green" && count > green
            green = count
        elseif col == "blue" && count > blue
            blue = count
        end
    end
    return red*green*blue
end

function calculateIdSum(boolList)
    sum = 0
    for (i,value) in enumerate(boolList)
        sum += i * value
    end
    return(sum)
end

function gameWorks(game::DiceGame, red::Int, green::Int, blue::Int)
    flatGame = flattenGame(game)
    return(prod(validate.(flatGame, blue, red, green)))
end

function validate(dice::DiceCount, blue::Int, red::Int, green::Int)
    col = dice.color
    count = dice.count
    if col == "blue" && blue < count
        return(false)
    elseif col == "green" && green < count
        return(false)
    elseif col == "red" && red < count
        return(false)
    end
    return(true)
end

function flattenGame(game::DiceGame)
    rounds = game.rounds
    allPickedDice = [round.sets for round in rounds]
    return([(allPickedDice...)...])
end

### Parsing Stuff ###
function stringToGameSet(str)
    separatedStr = split(str, "\n")
    return(stringToGame.(separatedStr))
end

function stringToGame(str)
    separatedStr = split(str, ":")
    id = parse(Int, replace(first(separatedStr),r"[^\d]" => ""))
    rounds = split(last(separatedStr), ";")
    return DiceGame(id, stringToRound.(rounds))
end

function stringToRound(str)
   separatedStr = split(str, ",")
   coolList = stringToDice.(separatedStr)
   return(DiceGameRound(coolList))
end

function stringToDice(inp)
    num = parse(Int, replace(inp,r"[^\d]" => ""))
    str = replace(inp,r"[^a-z]" => "")
    return(DiceCount(num,str))
end
