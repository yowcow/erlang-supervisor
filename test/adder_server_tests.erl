-module(adder_server_tests).

-include_lib("eunit/include/eunit.hrl").

setup() ->
    adder_server:start_link().

cleanup(_) ->
    adder_server:stop().

adder_server_test_() ->
    {
        setup,
        fun setup/0,
        fun cleanup/1,
        [
            fun test_do/0
        ]
    }.

test_do() ->
    Cases = [
        {"2 numbers", [2, 3], 5},
        {"3 numbers", [2, 3, 4], 9}
    ],
    F = fun({Name, Input, Expected}) ->
        Actual = adder_server:do(Input),
        ?assertEqual(Expected, Actual, Name)
    end,
    lists:map(F, Cases).
