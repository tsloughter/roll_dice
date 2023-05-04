%%%-------------------------------------------------------------------
%% @doc roll_dice public API
%% @end
%%%-------------------------------------------------------------------

-module(roll_dice_app).

-behaviour(application).

-export([start/2, stop/1]).

-include("roll_dice_instruments.hrl").
-include_lib("opentelemetry_api_experimental/include/otel_meter.hrl").

start(_StartType, _StartArgs) ->
    create_instruments(),
    roll_dice_sup:start_link().

stop(_State) ->
    ok.

%% internal functions

create_instruments() ->
    ?create_counter(?DICE_SUM, #{description => <<"Sum of every dice roll.">>,
                                 unit => '1'}).
