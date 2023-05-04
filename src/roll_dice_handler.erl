-module(roll_dice_handler).

-export([handle/2,
         handle_event/3]).

-include_lib("elli/include/elli.hrl").
-behaviour(elli_handler).

-include("roll_dice_instruments.hrl").
-include_lib("opentelemetry_api_experimental/include/otel_meter.hrl").

handle(Req, _Args) ->
    handle(Req#req.method, elli_request:path(Req), Req).

handle('GET', [<<"rolldice">>], _Req) ->
    Result = do_roll(),
    ?counter_add(?DICE_SUM, Result, #{}),
    {ok, [], erlang:integer_to_binary(Result)}.

handle_event(_Event, _Data, _Args) ->
    ok.

%%

-spec do_roll() -> binary().
do_roll() ->
    rand:uniform(6).
