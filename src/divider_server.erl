-module(divider_server).

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
    gen_server:call(?MODULE, {divide, Thing}, 20000).

init([]) ->
    process_flag(trap_exit, true),
    io:format("~p starting~n", [?MODULE]),
    {ok, 0}.

handle_call({divide, [A, B]}, _From, N) ->
    Result = A / B,
    {reply, Result, N + 1};
handle_call({divide, [A, B, C]}, _From, N) ->
    alarm_handler:set_alarm(tooHot),
    Result = A / B / C,
    alarm_handler:clear_alarm(tooHot),
    {reply, Result, N + 1};
handle_call(Param, _From, N) ->
    error_logger:error_msg("invalid input: ~p", [Param]),
    {reply, undefined, N}.

handle_cast(_Msg, N) -> {noreply, N}.

handle_info(_Msg, N) -> {noreply, N}.

terminate(_Reason, _N) ->
    io:format("~p stopping~n", [?MODULE]),
    ok.

code_change(_OldVsn, N, _Extra) -> {ok, N}.
