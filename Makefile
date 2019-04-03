LOGDIR := /var/tmp/supervisor-error-log
EBIN := ./_build/default/lib/erlang-supervisor/ebin

all: $(LOGDIR)
	rebar3 compile
	rebar3 release -n erlang_sup_app_dev
	rebar3 release -n erlang_sup_app_prod

$(LOGDIR):
	mkdir -p $@

shell:
	#rebar3 shell
	erl -pa $(EBIN) -boot start_sasl -config elog3

#run:
#	erl -pa $(EBIN) -noshell -boot start_sasl -s erlang-supervisor start_link -s init stop

test:
	rebar3 eunit

clean:
	rm -rf _build $(LOGDIR)

.PHONY: all shell run test clean
