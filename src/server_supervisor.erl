-module(server_supervisor).

-behavior(supervisor).

-export([
    start_link/1,
    start_in_shell/0,
    stop/0,
    init/1
]).

start_link(Args) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, Args).

start_in_shell() ->
    {ok, Pid} = start_link([]),
    unlink(Pid).

stop() ->
    Pid = whereis(?MODULE),
    unlink(Pid),
    exit(Pid, shutdown).

init([]) ->
    gen_event:swap_handler(
        alarm_handler,
        {alarm_handler, swap},
        {my_alarm_handler, xyz}
    ),
    {ok, {
        {one_for_one, 3, 10},
        [
            {
                adder,
                {adder_server, start_link, []},
                permanent,
                10000,
                worker,
                [adder_server]
            },
            {
                multiplier,
                {multiplier_server, start_link, []},
                permanent,
                10000,
                worker,
                [multiplier_server]
            },
            {
                divider,
                {divider_server, start_link, []},
                permanent,
                10000,
                worker,
                [divider_server]
            }
        ]
    }}.
