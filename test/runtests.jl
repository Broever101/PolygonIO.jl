using ConfigEnv
using PolygonIO
using TypedTables
using Test


dotenv()

const API_KEY = ENV["API_KEY"]
const tabular_opts = PolyOpts(API_KEY, Table)
const regular_opts = PolyOpts(API_KEY, nothing)


@testset "Reference API" begin
    # tickets test
    @test tickers(tabular_opts, "bitcoin") |> length == 10
    @test tickers(regular_opts, "bitcoin") |> length == 10

    # ticker_types test
    @test ticker_types(tabular_opts) |> length == 2
    @test ticker_types(regular_opts) |> length == 2

    # ticker_details test
    @test ticker_details(tabular_opts, "AAPL") |> length == 1
    @test ticker_details(regular_opts, "AAPL") |> length >= 28

    # ticker_details_vX next version test
    @test ticker_details_vX(tabular_opts, "AAPL", "2019-07-31") |> length == 1
    @test ticker_details_vX(regular_opts, "AAPL", "2019-07-31") |> length == 19

    # ticker_news test
    @test ticker_news(tabular_opts, "AAPL") |> length == 10
    @test ticker_news(regular_opts, "AAPL") |> length == 10

    # markets test
    @test markets(regular_opts) |> length >= 7
    @test markets(tabular_opts) |> length >= 7

    # locales test
    @test locales(regular_opts) |> length >= 19
    @test locales(tabular_opts) |> length >= 19

    # stock_splits test
    @test stock_splits(regular_opts, "AAPL") |> length >= 4
    @test stock_splits(tabular_opts, "AAPL") |> length >= 4

    # stock_dividends test
    @test stock_dividends(regular_opts, "AAPL") |> length >= 65
    @test stock_dividends(tabular_opts, "AAPL") |> length >= 65

    # stock_financials test
    @test stock_financials(regular_opts, "AAPL") |> length == 5
    @test stock_financials(tabular_opts, "AAPL") |> length == 5

    # market_holidays test
    @test market_holidays(regular_opts) |> length >= 1
    @test market_holidays(tabular_opts) |> length >= 1

    # market_status test
    @test market_status(regular_opts) |> length >= 6
    @test market_status(tabular_opts) |> length >= 1

    # stock_exchanges test
    @test stock_exchanges(regular_opts) |> length >= 30
    @test stock_exchanges(tabular_opts) |> length >= 30

    # condition_mappings test
    @test condition_mappings(regular_opts, "trades") |> length >= 1
    @test condition_mappings(tabular_opts, "quotes") |> length >= 1

    # stock_exchanges test
    @test crypto_exchanges(regular_opts) |> length >= 5
    @test crypto_exchanges(tabular_opts) |> length >= 5
end


@testset "Stock API" begin
    # trades test
    @test stocks_trades(tabular_opts, "AAPL", "2020-10-14") |> length == 10
    @test stocks_trades(regular_opts, "AAPL", "2020-10-14") |> length == 10

    # quotes_nbbo test
    @test stocks_quotes_nbbo(tabular_opts, "AAPL", "2020-10-14") |> length == 10
    @test stocks_quotes_nbbo(regular_opts, "AAPL", "2020-10-14") |> length == 10

    # last_trade_symbol test
    @test stocks_last_trade_symbol(tabular_opts, "AAPL") |> length == 1
    @test stocks_last_trade_symbol(regular_opts, "AAPL") |> length >= 1

    # last_quote_symbol test
    @test stocks_last_quote_symbol(regular_opts, "AAPL") |> length >= 1
    @test stocks_last_quote_symbol(tabular_opts, "AAPL") |> length == 1

   # daily_open_close test
   @test stocks_daily_open_close(tabular_opts, "AAPL", "2020-10-14") |> length == 1
   @test stocks_daily_open_close(regular_opts, "AAPL", "2020-10-14") |> length >= 10

    # grouped_daily_bars test
    @test stocks_grouped_daily_bars(tabular_opts, "2020-10-14"; adjusted=true) |> length >= 8000
    @test stocks_grouped_daily_bars(regular_opts, "2020-10-14"; adjusted=false) |> length >= 8000

    # previous_close test
    @test stocks_previous_close(tabular_opts, "AAPL") |> length == 1
    @test stocks_previous_close(regular_opts, "AAPL") |> length == 1

    # aggregates_bars test
    @test stocks_aggregates_bars(tabular_opts, "AAPL") |> length == 1
    @test stocks_aggregates_bars(regular_opts, "AAPL") |> length == 1

    # snapshot_all_tickers test
    @test stocks_snapshot_all_tickers(tabular_opts, "AAPL,AMZN") |> length == 2
    @test stocks_snapshot_all_tickers(regular_opts, "AAPL,AMZN") |> length == 2

    # snapshot_ticker test
    @test stocks_snapshot_ticker(tabular_opts, "AAPL") |> length == 9
    @test stocks_snapshot_ticker(regular_opts, "AAPL") |> length == 9

    # snapshot_gainers_losers test
    @test stocks_snapshot_gainers_losers(tabular_opts, "losers") |> length >= 20
    @test stocks_snapshot_gainers_losers(regular_opts, "gainers") |> length >= 20
end


@testset "Crypto API" begin
    # last_trade_crypto_pair test
    @test last_trade_crypto_pair(regular_opts) |> length >= 5
    @test last_trade_crypto_pair(tabular_opts) |> length >= 1

    # crypto_daily_open_close test
    @test crypto_daily_open_close(regular_opts, "BTC", "USD", "2020-10-14"; adjusted=true) |> length >= 7
    @test crypto_daily_open_close(tabular_opts, "BTC", "USD", "2020-10-14"; adjusted=false) |> length >= 7

    # historic_crypto_trades test
    @test historic_crypto_trades(regular_opts, "BTC", "USD", "2020-10-14"; limit=100) |> length >= 7
    @test historic_crypto_trades(tabular_opts, "BTC", "USD", "2020-10-14"; limit=100) |> length >= 7

    # crypto_grouped_daily_bars test
    @test crypto_grouped_daily_bars(regular_opts, "2020-10-14"; adjusted=true) |> length >= 1
    @test crypto_grouped_daily_bars(tabular_opts, "2020-10-14"; adjusted=false) |> length >= 1

    # crypto_previous_close test
    @test crypto_previous_close(regular_opts, "X:BTCUSD"; adjusted=true) |> length == 1
    @test crypto_previous_close(tabular_opts, "X:BTCUSD"; adjusted=false) |> length == 1

    # crypto_aggregates_bars test
    @test crypto_aggregates_bars(regular_opts, "X:BTCUSD", 1, "day", "2020-10-14", "2020-10-14"; adjusted=true) |> length == 1
    @test crypto_aggregates_bars(tabular_opts, "X:BTCUSD", 1, "day", "2020-10-14", "2020-10-14"; adjusted=false) |> length == 1

    # crypto_snapshot_all_tickers test
    @test crypto_snapshot_all_tickers(regular_opts) |> length >= 1
    @test crypto_snapshot_all_tickers(tabular_opts) |> length >= 1

    # crypto_snapshot_ticker test
    @test crypto_snapshot_ticker(regular_opts, "X:BTCUSD") |> length >= 1
    @test crypto_snapshot_ticker(tabular_opts, "X:BTCUSD") |> length >= 1

    # crypto_snapshot_ticker_full_book
    @test crypto_snapshot_ticker_full_book(regular_opts, "X:BTCUSD") |> length >= 1
    @test crypto_snapshot_ticker_full_book(tabular_opts, "X:BTCUSD") |> length >= 1

    # crypto_snapshot_gainers_losers test
    @test crypto_snapshot_gainers_losers(regular_opts, "gainers") |> length >= 1
    @test crypto_snapshot_gainers_losers(tabular_opts, "losers") |> length >= 1
end


@testset "Forex API" begin
    # historic_forex_ticks test
    @test historic_forex_ticks(regular_opts, "AUD", "USD", "2020-10-14"; limit=100) |> length >= 1
    @test historic_forex_ticks(tabular_opts, "AUD", "USD", "2020-10-14"; limit=100) |> length >= 1

    # real_time_currency_conversion test
    @test real_time_currency_conversion(regular_opts, "AUD", "USD") |> length >= 8
    @test real_time_currency_conversion(tabular_opts, "AUD", "USD") |> length >= 1

    # last_quote_currency_pair test
    @test last_quote_currency_pair(regular_opts, "AUD", "USD") |> length >= 1
    @test last_quote_currency_pair(tabular_opts, "AUD", "USD") |> length >= 1

    # forex_grouped_daily_bars test
    @test forex_grouped_daily_bars(regular_opts, "2020-10-14"; adjusted=true) |> length >= 1
    @test forex_grouped_daily_bars(tabular_opts, "2020-10-14"; adjusted=false) |> length >= 1

    # forex_previous_close test
    @test forex_previous_close(regular_opts, "C:EURUSD"; adjusted=true) |> length >= 1
    @test forex_previous_close(tabular_opts, "C:EURUSD"; adjusted=false) |> length >= 1

    # forex_aggregates_bars test
    @test forex_aggregates_bars(regular_opts, "C:EURUSD", 1, "day", "2020-10-14", "2020-10-14"; adjusted=true) |> length >= 1
    @test forex_aggregates_bars(tabular_opts, "C:EURUSD", 1, "day", "2020-10-14", "2020-10-14"; adjusted=false) |> length >= 1

    # forex_snapshot_ticker test
    @test forex_snapshot_ticker(regular_opts, "C:EURUSD") |> length >= 1
    @test forex_snapshot_ticker(tabular_opts, "C:EURUSD") |> length >= 1

    # forex_snapshot_all_tickers test
    @test forex_snapshot_all_tickers(regular_opts) |> length >= 1
    @test forex_snapshot_all_tickers(tabular_opts) |> length >= 1

    # forex_snapshot_gainers_losers test
    @test forex_snapshot_gainers_losers(regular_opts, "gainers") |> length >= 1
    @test forex_snapshot_gainers_losers(tabular_opts, "losers") |> length >= 1
end

@testset "Options API" begin 
    # options_aggregates test
    @test options_aggregates(regular_opts, "O:TSLA210903C00700000", 1, "day", "2021-07-22", "2021-07-22") |> length >= 1
    @test options_aggregates(tabular_opts, "O:TSLA210903C00700000", 1, "day", "2021-07-22", "2021-07-22") |> length >= 1

    # options_daily_open_close test
    @test options_daily_open_close(regular_opts, "O:TSLA210903C00700000", "2021-07-22") |> length >= 1
    @test options_daily_open_close(tabular_opts, "O:TSLA210903C00700000", "2021-07-22") |> length >= 1

    # options_previous_close test
    @test options_previous_close(regular_opts, "O:TSLA210903C00700000") |> length >= 1
    @test options_previous_close(tabular_opts, "O:TSLA210903C00700000") |> length >= 1

    # options_trade test
    @test options_trade(regular_opts, "O:TSLA210903C00700000") |> length >= 1
    @test options_trade(tabular_opts, "O:TSLA210903C00700000") |> length >= 1
   
    # options_last_trade test 
    @test options_last_trade(regular_opts, "O:TSLA210903C00700000") |> length >= 1
    @test options_last_trade(tabular_opts, "O:TSLA210903C00700000") |> length >= 1

    # options_quotes test
    @test options_quotes(regular_opts,"O:TSLA210903C00700000") |> length >= 1
    @test options_quotes(tabular_opts,"O:TSLA210903C00700000") |> length >= 1

    # options_snapshot_option_contract test
    @test options_snapshot_option_contract(regular_opts, "AAPL", "O:AAPL230616C00150000") |> length >= 1
    @test options_snapshot_option_contract(tabular_opts, "AAPL", "O:AAPL230616C00150000") |> length >= 1

    # options_contracts test
    @test options_contracts(regular_opts, "O:EVRI240119C00002500") |> length >= 1
    @test options_contracts(tabular_opts, "O:EVRI240119C00002500") |> length >= 1
end