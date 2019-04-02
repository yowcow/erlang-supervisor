erlang-supervisor
=================

An OTP library

HOW TO RUN
----------

Connect to Erlang shell:

    % make clean all shell

Start application in shell:

    > application:start('erlang-supervisor').

Call adder server:

    > adder_server:add([2, 3, 4]).

Call multiplier server:

    > multiplier_server:mul([2, 3, 4]).

Call divider server and let it fail:

    > divider_server:divide([2, 3, 0]).

Start report browser:

    > rb:start([{max, 10}]).

List reports:

    > rb:list().

Show a report:

    > rb:show(1).

Stop application:

    > application:stop('erlang-supervisor').

Completely finish Erlang shell:

    > init:stop().
