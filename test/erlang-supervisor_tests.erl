-module('erlang-supervisor_tests').

-include_lib("eunit/include/eunit.hrl").

-define(APP, 'erlang-supervisor').

setup() ->
    {ok, Started} = application:ensure_all_started(?APP),
    Started.

cleanup(Started) ->
    [application:stop(App) || App <- Started],
    application:unload(?APP).

'erlang-supervisor_test_'() ->
    {
        setup,
        fun setup/0,
        fun cleanup/1,
        [
            fun test_adder_do/0
        ]
    }.

test_adder_do() ->
    Cases = [
        {"2 numbers", [2, 3], 5},
        {"3 numbers", [2, 3, 4], 9}
    ],
    F = fun({Name, Input, Expected}) ->
        Actual = adder_server:do(Input),
        ?assertEqual(Expected, Actual, Name)
    end,
    lists:map(F, Cases).
