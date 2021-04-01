using Test
using JSON
using GraphQLCodegen

let 
    t1 = @NamedTuple begin
        a::Int
    end
    d1 = JSON.parse("""{"a": 1}""")
    
    @test parse_nt(t1, d1)  == ((a=1),)
end


let 
    t1 = @NamedTuple begin
        a::Union{Int, Nothing}
    end

    d1 = JSON.parse("""{"a": 1}""")
    @test parse_nt(t1, d1) == ((a=1),)

    d2 = JSON.parse("""{"a": null}""")
    @info parse_nt(t1, d2)
    @test parse_nt(t1, d2) == ((a=nothing),)
end 


let 
    Members = @NamedTuple begin
        user::String
    end
    
    Repos = @NamedTuple begin
        groups::Union{Vector{Members}, Nothing}
    end

    d = JSON.parse("""{"groups": [{"user": "mark"}]}""")

    @test parse_nt(Repos, d) == Repos(([Members(("mark",)) ],))


    d2 = JSON.parse("""{"groups": null}""")
    @test parse_nt(Repos, d2) == Repos((nothing,))

end

let 
    Repos = @NamedTuple begin
        groups::Vector{Union{Nothing, String}}
    end
    d = JSON.parse("""{"groups": ["mark", null, "brent"]}""")
    @test parse_nt(Repos, d) == Repos((["mark", nothing, "brent"],))
end

let 
    s = gql"""my graphql string"""
    @test s == "my graphql string"
end


# @test parse_nt(t2, d2) == 
# @test parse_nt(t2, d2) == ((a=1),))
