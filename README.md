# GraphQLCodegen.jl

This project has facilitates a codegen workflow when consuming GraphQL apis in Julia.

This project exports: 
- the `gql` macro which helps the code generator to find the GraphQL queries
- The `parse_nt` function which parses `Dict` into Julia Named Tuples.

### Usage
See https://github.com/laurium-labs/GithubGraphQLExample.jl as an example project using a code generation workflow. 
