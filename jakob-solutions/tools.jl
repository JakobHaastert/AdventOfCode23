function readFile(x)
    parentPath = dirname(pwd())
    path = "$parentPath/input/$x.txt"
    file = open(path, "r")
    content = read(file, String)
    close(file)
    return content
end

function toInt(x)
    parse(Int, x)
end