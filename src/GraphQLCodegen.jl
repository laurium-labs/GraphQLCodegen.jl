module GraphQLCodegen

function parse_nt(T::Type, s::String)
  if T <: AbstractString
    return s
  elseif string(T) == s
    return T
  elseif s ∈ string.(instances(T))
    return argmax(inst -> string(inst) == s, instances(T))
  else
    return convert(T, s)
  end
end

parse_nt(::Type{Union{T2,Nothing}}, s::String) where {T2} = parse_nt(T2, s)
parse_nt(T::Any, s) = convert(T, s)
parse_nt(::Type{Union{T2,Nothing}}, vec::Vector) where {T2} = isempty(vec) ? [] : parse_nt.(eltype(T2), vec)
parse_nt(::Type{Vector{T2}}, vec::Vector) where {T2} = isempty(vec) ? [] : parse_nt.(T2, vec)

function parse_nt(::Type{Vector{Union{T2,Nothing}}}, vec::Vector) where {T2}
  isempty(vec) ? [] : map(v -> isnothing(v) ? nothing : parse_nt(T2, v), vec)
end

function parse_nt(::Type{Union{T,Nothing}}, d::Dict) where {T}
  return T((haskey(d, String(t)) ? parse_nt(fieldtype(T, t), d[String(t)]) : nothing for t in fieldnames(T)))
end
function parse_nt(T::Type, d::Dict)::T
  T((haskey(d, String(t)) ? parse_nt(fieldtype(T, t), d[String(t)]) : nothing for t in fieldnames(T)))
end

macro gql_str(str::String)
  return str # str is the query to turn into a function call
end

export parse_nt, @gql_str
end # module