module PolygonIO

# Gloabl Imports
using StructTypes
using JSON3
using HTTP
using TypedTables


######### Import modules & utils ################
include("utils.jl")
include("crypto_api.jl")
include("custom_structs.jl")
include("forex_api.jl")
include("reference_api.jl")
include("stock_api.jl")
include("streaming_socket.jl")



######### Global export of user API  ################
export tickers, PolyOpts

end
