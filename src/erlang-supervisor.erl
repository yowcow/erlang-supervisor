-module('erlang-supervisor').

-behavior(application).

-export([
    start/2,
    stop/1
]).

start(_Type, Args) ->
    server_supervisor:start_link(Args).

stop(_State) ->
    ok.
