module GraphQLCodegen

  parse_nt(T::Any, s) = convert(T,s)
  parse_nt(::Type{Union{T2, Nothing}}, vec::Vector) where T2 = isempty(vec) ? [] : parse_nt.(eltype(T2), vec)
  parse_nt(::Type{Vector{T2}}, vec::Vector) where T2 = isempty(vec) ? [] : parse_nt.(T2, vec)
  
  function parse_nt(::Type{Vector{Union{T2, Nothing}}}, vec::Vector) where T2
    isempty(vec) ? [] : map(v -> isnothing(v) ? nothing : parse_nt(T2, v), vec)
  end
    
  function parse_nt(::Type{Union{T, Nothing}}, d::Dict)::T 
    return (haskey(d, String(t)) ? parse_nt(fieldtype(T, t), d[String(t)]) : nothing for t in fieldnames(T))
  end
  function parse_nt(T::Type, d::Dict)::T
    T((haskey(d, String(t)) ? parse_nt(fieldtype(T, t), d[String(t)]) : nothing for t in fieldnames(T)))
  end

  macro gql_str(str::String)
    return str # str is the query to turn into a function call
  end

  export parse_nt, @gql_str
end # module