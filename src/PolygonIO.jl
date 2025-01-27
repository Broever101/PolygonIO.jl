module PolygonIO

# Gloabl Imports
using JSON3
using JSONTables
using HTTP


######### Import modules & utils ################
include("custom_structs.jl")
include("utils.jl")
include("urls.jl")
include("crypto_api.jl")
include("forex_api.jl")
include("reference_api.jl")
include("stocks_api.jl")
include("streaming_socket.jl")
include("options_api.jl")



######### Global export of user API  ################
    # Reference API
export PolyOpts, tickers, ticker_types, ticker_details, ticker_details_vX,
        ticker_news, markets, locales, stock_splits, stock_dividends,
        stock_financials, market_holidays, market_status, stock_exchanges,
        condition_mappings, crypto_exchanges,

    # Stock API
        stocks_trades, stocks_quotes_nbbo, stocks_last_trade_symbol, stocks_last_quote_symbol,
        stocks_daily_open_close, stocks_grouped_daily_bars, stocks_previous_close,
        stocks_aggregates_bars, stocks_snapshot_all_tickers, stocks_snapshot_ticker,
        stocks_snapshot_gainers_losers,

    # Crypto API
        last_trade_crypto_pair, crypto_daily_open_close, historic_crypto_trades,
        crypto_grouped_daily_bars, crypto_previous_close, crypto_aggregates_bars,
        crypto_snapshot_all_tickers, crypto_snapshot_ticker, crypto_snapshot_ticker_full_book,
        crypto_snapshot_gainers_losers,

    # Forex API
        historic_forex_ticks, real_time_currency_conversion, last_quote_currency_pair,
        forex_grouped_daily_bars, forex_previous_close, forex_aggregates_bars,
        forex_snapshot_ticker, forex_snapshot_all_tickers, forex_snapshot_gainers_losers,

    # Options API
        options_aggregates, options_daily_open_close, options_previous_close, options_trade,
        options_last_trade, options_quotes, options_snapshot_option_contract, options_contracts
end
