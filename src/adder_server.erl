-module(adder_server).

-behavior(gen_server).

-export([
    do/1,
    start_link/0,
    stop/0
]).

-export([
    init/1,
    handle_call/3,
    handle_cast/2,
    handle_info/2,
    terminate/2,
    code_change/3
]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

stop() ->
    gen_server:stop(?MODULE).

do(Thing) ->
    gen_server:call(?MODULE, {add, Thing}, 20000).

init([]) ->
    process_flag(trap_exit, true),
    io:format("~p starting~n", [?MODULE]),
    {ok, 0}.

handle_call({add, [A, B]}, _From, N) ->
    {reply, A + B, N + 1};
handle_call({add, [A, B, C]}, _From, N) ->
    {reply, A + B + C, N + 1};
handle_call(Param, _From, N) ->
    error_logger:error_msg("invalid input: ~p", [Param]),
    {reply, undefined, N}.

handle_cast(_Msg, N) -> {noreply, N}.

handle_info(_Msg, N) -> {noreply, N}.

terminate(_Reason, _N) ->
    io:format("~p stopping~n", [?MODULE]),
    ok.

code_change(_OldVsn, N, _Extra) -> {ok, N}.
