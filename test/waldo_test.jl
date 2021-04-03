
let 
    response = """{"data":{"allWoodLoads":{"nodes":[{"loadType":"Veneer","id":263},{"loadType":"Veneer","id":279},{"loadType":"Veneer","id":307},{"loadType":"Veneer","id":329},{"loadType":"Veneer","id":358},{"loadType":"Veneer","id":413},{"loadType":"Veneer","id":467},{"loadType":"Veneer","id":468},{"loadType":"Veneer","id":469},{"loadType":"Veneer","id":471}]}}}"""

    WoodLoadsVariables = @NamedTuple  begin
        type::AbstractString
    end
    
    
    WoodLoadsResult_allWoodLoads_nodes = @NamedTuple begin
        loadType::Union{Nothing,AbstractString}
        id::Int64
    end
    
    WoodLoadsResult_allWoodLoads = @NamedTuple begin
        nodes::Vector{Union{Nothing,WoodLoadsResult_allWoodLoads_nodes}}
    end
    
    WoodLoadsResult = @NamedTuple begin
        allWoodLoads::WoodLoadsResult_allWoodLoads
    end

    @test parse_nt(WoodLoadsResult, JSON.parse(response)["data"]).allWoodLoads.nodes[1].id == 263
end