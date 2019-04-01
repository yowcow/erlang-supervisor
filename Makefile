EBIN := ./_build/default/lib/erlang-supervisor/ebin

all:
	rebar3 compile

shell:
	erl -pa $(EBIN)

run:
	erl -pa $(EBIN) -noshell -s erlang-supervisor start_link -s init stop

test:
	rebar3 eunit

clean:
	rm -rf _build

.PHONY: all shell run test clean
