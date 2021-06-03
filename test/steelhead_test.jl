let
    response = """{"data":{"allWorkOrders":{"nodes":[{"id":1,"createdAt":"2021-04-27T15:17:33.629391+00:00","creatorId":1},{"id":2,"createdAt":"2021-04-27T20:00:35.878845+00:00","creatorId":1}]}}}"""

    AllWorkOrdersResult_allWorkOrders_nodes = @NamedTuple begin
        id::Int64
        createdAt::Union{Nothing,String}
        creatorId::Int64
      end
      
      AllWorkOrdersResult_allWorkOrders = @NamedTuple begin
        nodes::Vector{AllWorkOrdersResult_allWorkOrders_nodes}
      end
      
      AllWorkOrdersResult = @NamedTuple begin
        allWorkOrders::AllWorkOrdersResult_allWorkOrders
      end

    @test parse_nt(AllWorkOrdersResult, JSON.parse(response)["data"]).allWorkOrders.nodes[1].id == 1

end