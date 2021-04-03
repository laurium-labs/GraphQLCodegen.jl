module GraphQLCodegen

  function parse_nt(T::Any, s)::T
    s
  end
  
  function parse_nt(::Type{Union{T2, Nothing}}, vec::Vector) where T2
    [map(v -> parse_nt(eltype(T2), v), vec)...]
  end

  function parse_nt(::Type{Vector{Union{T2, Nothing}}}, vec::Vector) where T2
    [map(v -> isnothing(v) ? nothing : parse_nt(T2, v), vec )...]
  end
  
  
  function parse_nt(T::Type, d::Dict)::T
    T((haskey(d, String(t)) ?  parse_nt(fieldtype(T, t), d[String(t)]) : nothing for t in fieldnames(T)))
  end
  
  function parse_nt(::Type{Union{T, Nothing}}, d::Dict) where {T} 
    T((haskey(d, String(t)) ? parse_nt(fieldtype(T, t), d[String(t)]) : nothing for t in fieldnames(T)) )
  end

  macro gql_str(str::String)
    # str is the query to turn into a function call
    return str
  end


  export parse_nt
  export @gql_str
end # module
