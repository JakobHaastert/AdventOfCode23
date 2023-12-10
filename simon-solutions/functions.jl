read_data = function(file_name::String)
    path = string("./input/simon/", file_name, ".txt")
    input = open(path) do file
        read(file, String)
    end
    return(input)
end