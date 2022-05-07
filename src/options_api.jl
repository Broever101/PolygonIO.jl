################## Aggregates(Bars) ##################
"""
    options_aggregates(opts::PolyOpts, options_ticker::String, multiplier::Int, timespan::String, from::String, to::String; 
                       limit=120, kwargs...)

Get aggregate bars for an option contract over a given date range in custom time window sizes.
For example, if timespan = 'minute' and multiplier = '5' then 5-minute bars will be returned.

# Arguments
 * opts::PolyOpts: The PolyOpts object used to configure the request.
 * options_ticker: The ticker symbol of the options contract.
 * multiplier: The size of the timespan multiplier.
 * timespan: The size of the time window.
 * from: The start of the aggregate time window.
 * to: The end of the aggregate time window.

# Example
```julia-repl
julia> opts = PolyOpts(API_KEY, nothing)
julia> options_aggregates(opts, "O:TSLA210903C00700000", 1, "day", "2021-07-22", "2021-07-22")
```

# Returns
* A JSON3.Array or specified tabular representation of the JSON3.Array.
* See https://polygon.io/docs/options/get_v2_aggs_ticker__optionsticker__range__multiplier___timespan___from___to for documentation on response attributes and supported keyword arguments.
"""
function options_aggregates(opts::PolyOpts, options_ticker::String, multiplier::Int, timespan::String, from::String, to::String; 
                            limit=120, kwargs...)
    params = Dict(
        "apiKey" => opts.api_key,
        "optionsTicker" => options_ticker,
        "multiplier" => multiplier,
        "timespan" => timespan,
        "from" => from,
        "to" => to, 
    )

    merge!(params, Dict(kwargs))
    options_aggregates_url = "$options_aggregates_base_url/$options_ticker/range/$multiplier/$timespan/$from/$to"
    return generate_output_from_url(NoSinkYesResults(), options_aggregates_url, params, opts.sink)
end


################## Daily Open/Close ##################

"""
    options_daily_open_close(opts::PolyOpts, options_ticker::String, date::String; adjusted=true)

# Arguments
 * opts::PolyOpts: The PolyOpts object used to configure the request.
 * options_ticker: The ticker symbol of the options contract.
 * date: The date of the requested open/close in the format YYYY-MM-DD.
 * adjusted: Whether or not the results are adjusted for splits. 
             By default, results are adjusted. Set this to false to get results that are NOT adjusted for splits.

# Example
```julia-repl
julia> opts = PolyOpts(API_KEY, nothing)
julia> options_daily_open_close(opts, "O:TSLA210903C00700000", "2021-07-22")
```

# Returns
* A JSON3.Array or specified tabular representation of the JSON3.Array.
* See https://polygon.io/docs/options/get_v1_open-close__optionsticker___date for documentation on response attributes and supported keyword arguments.
"""
function options_daily_open_close(opts::PolyOpts, options_ticker::String, date::String; adjusted=true)
    params = Dict(
        "apiKey" => opts.api_key,
        "optionsTicker" => options_ticker,
        "date" => date, 
        "adjusted" => adjusted
    )

    options_daily_open_close_url = "$options_daily_open_close_base_url/$options_ticker/$date"
    return generate_output_from_url(NoSinkNoResults(), options_daily_open_close_url, params, opts.sink)
end

################## Previous Close ##################

"""
    options_previous_close(opts::PolyOpts, options_ticker::String; adjusted=true)


# Arguments
 * opts::PolyOpts: The PolyOpts object used to configure the request.
 * options_ticker: The ticker symbol of the options contract.
 * adjusted: Whether or not the results are adjusted for splits. 
             By default, results are adjusted. Set this to false to get results that are NOT adjusted for splits.

# Example
```julia-repl
julia> opts = PolyOpts(API_KEY, nothing)
julia> options_previous_close(opts, "O:TSLA210903C00700000")
```

# Returns
* A JSON3.Array or specified tabular representation of the JSON3.Array.
* See https://polygon.io/docs/options/get_v1_open-close__optionsticker___date for documentation on response attributes and supported keyword arguments.
"""
function options_previous_close(opts::PolyOpts, options_ticker::String; adjusted=true)
    params = Dict(
        "apiKey" => opts.api_key,
        "optionsTicker" => options_ticker,
        "adjusted" => adjusted
    )

    options_previous_close_url = "$options_previous_close_base_url/$options_ticker/prev"
    return generate_output_from_url(NoSinkYesResults(), options_previous_close_url, params, opts.sink)
end


################## Trades ##########################

"""
    options_trade(opts::PolyOpts, options_ticker::String; order="asc", limit=1, kwargs...)

# Arguments
 * opts::PolyOpts: The PolyOpts object used to configure the request.
 * options_ticker: The options ticker symbol to get trades for.
 * timestamp: Query by trade timestamp. Either a date with the format YYYY-MM-DD or a nanosecond timestamp.
 * order: Order results based on the sort field.
 * limit: Limit the number of results returned, default is 1 and max is 50000.

# Example
```julia-repl
julia> opts = PolyOpts(API_KEY, nothing)
julia> options_trade(opts, "O:TSLA210903C00700000")
```

# Returns
* A JSON3.Array or specified tabular representation of the JSON3.Array.
* See https://polygon.io/docs/options/get_v3_trades__optionsticker for documentation on response attributes and supported keyword arguments.
"""
function options_trade(opts::PolyOpts, options_ticker::String, timestamp::string="2021-07-22"; order="asc", limit=1, sort="timestamp", kwargs...)
    params = Dict(
        "apiKey" => opts.api_key,
        "optionsTicker" => options_ticker, 
        "timestamp" => timestamp,
        "order" => order,
        "limit" => limit, 
        "sort" => sort
    )

    merge!(params, Dict(kwargs))
    options_trades_url = "$options_trades_base_url/$options_ticker"
    return generate_output_from_url(YesSinkYesResults(), options_trades_url, params, opts.sink)
end



################## Last Trade ######################

"""
    options_last_trade(opts::PolyOpts, options_ticker::String)

# Arguments
 * opts::PolyOpts: The PolyOpts object used to configure the request.
 * options_ticker: The ticker symbol of the options contract.

# Example
```julia-repl
julia> opts = PolyOpts(API_KEY, nothing)
julia> options_last_trade(opts, "O:TSLA210903C00700000")
```

# Returns
* A JSON3.Array or specified tabular representation of the JSON3.Array.
* See https://polygon.io/docs/options/get_v2_last_trade__optionsticker for documentation on response attributes and supported keyword arguments.
"""
function options_last_trade(opts::PolyOpts, options_ticker::String)
    params = Dict(
        "apiKey" => opts.api_key, 
        "optionsTicker" => options_ticker
    )

    options_last_trade_url = "$options_last_trade_base_url/$options_ticker"
    return generate_output_from_url(NoSinkYesResults(), options_last_trade_url, params, opts.sink)
end

################## Quotes ######################

"""
    options_quotes(opts::PolyOpts, options_ticker::String; order="asc", limit=1, kwargs...)
    
# Arguments
 * opts::PolyOpts: The PolyOpts object used to configure the request.
 * options_ticker: The ticker symbol to get quotes for.
 * order: Order results based on the sort field.
 * limit: Limit the number of results returned, default is 1 and max is 50000.
 * sort: Sort field used for ordering.

# Example
```julia-repl
julia> opts = PolyOpts(API_KEY, nothing)
julia> options_quotes(opts,"O:TSLA210903C00700000")
```

# Returns
* A JSON3.Array or specified tabular representation of the JSON3.Array.
* See https://polygon.io/docs/options/get_v3_quotes__optionsticker for documentation on response attributes and supported keyword arguments.
"""
function options_quotes(opts::PolyOpts, options_ticker::String; order="asc", limit=1, sort="timestamp", kwargs...)
    params = Dict(
        "apiKey" => opts.api_key,
        "optionsTicker" => options_ticker, 
        "order" => order,
        "limit" => limit, 
    )

    merge!(params, Dict(kwargs))
    options_quotes_url = "$options_quotes_base_url/$options_ticker"
    return generate_output_from_url(YesSinkYesResults(), options_quotes_url, params, opts.sink)
end

################## Snapshot - Option Contract ##########################

"""
    options_snapshot_option_contract(opts::PolyOpts, underlying_asset::String, option_contract::String)

# Arguments
 * opts::PolyOpts: The PolyOpts object used to configure the request.
 * underlying_asset: The underlying ticker symbol of the option contract.
 * option_contract: The underlying ticker symbol of the option contract.

# Example
```julia-repl
julia> opts = PolyOpts(API_KEY, nothing)
julia> options_snapshot_option_contract(opts, "AAPL", "O:AAPL230616C00150000")
```

# Returns
* A JSON3.Array or specified tabular representation of the JSON3.Array.
* See https://polygon.io/docs/options/get_v3_snapshot_options__underlyingasset___optioncontract for documentation on response attributes and supported keyword arguments.
"""
function options_snapshot_option_contract(opts::PolyOpts, underlying_asset::String, option_contract::String)
    params = Dict(
        "apiKey" => opts.api_key,
        "underlyingAssert" => underlying_asset,
        "optionContract" => option_contract
    )

    options_snapshot_option_contract_url = "$options_snapshot_option_contract_base_url/$underlying_asset/$option_contract"
    return generate_output_from_url(YesSinkYesResults(), options_snapshot_option_contract_url, params, opts.sink)
end


################## Options contracts ##########################

"""
    options_contracts(opts::PolyOpts, options_ticker::String; as_of="2021-07-22")

# Arguments
 * opts::PolyOpts: The PolyOpts object used to configure the request.
 * options_ticker: Query for a contract by options ticker.
                   You can learn more about the structure of options tickers here:
                   https://polygon.io/blog/how-to-read-a-stock-options-ticker/
 * as_of: Specify a point in time for the contract as of this date with format YYYY-MM-DD. Defaults to today's date.

# Example
```julia-repl
julia> opts = PolyOpts(API_KEY, nothing)
julia> options_contracts(opts, "O:EVRI240119C00002500")
```

# Returns
* A JSON3.Array or specified tabular representation of the JSON3.Array.
* See https://polygon.io/docs/options/get_v3_reference_options_contracts__options_ticker for documentation on response attributes and supported keyword arguments.
"""
function options_contracts(opts::PolyOpts, options_ticker::String; as_of="")
    params = Dict(
        "apiKey" => opts.api_key,
        "optionsTicker" => options_ticker
        "as_of" => as_of
    )

    options_contracts_url = "$options_contracts_base_url/$options_ticker"
    return generate_output_from_url(NoSinkYesResults(), options_contracts_url, params, opts.sink)
end



