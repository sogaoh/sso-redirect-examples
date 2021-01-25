.PHONY:

help:
	cat Makefile


CONF_OPT := --config auth-client/config.yaml


# ecspresso
verify:
	ecspresso $(CONF_OPT) verify

create:
	ecspresso $(CONF_OPT) create

status:
	ecspresso $(CONF_OPT) status

diff:
	ecspresso $(CONF_OPT) diff

deploy:
	ecspresso $(CONF_OPT) deploy
