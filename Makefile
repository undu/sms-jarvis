TOP:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
NAME:=sms-jarvis
PYTHON=$(shell find ${TOP} -name '*.py')

PYLINT:=pylint
PYLINT_FLAGS:=
YAPF:=yapf
YAPF_FLAGS:=

ifndef VERBOSE
VERBOSE=0
endif

ifneq (${VERBOSE}, 0)
PYLINT_FLAGS+=--reports=y --score=y
endif

.PHONY: all pyformat format pylint lint docs

all: format lint docs

pyformat:
	${YAPF} ${YAPF_FLAGS} -i ${PYTHON}

format: pyformat

pylint:
	${PYLINT} ${PYLINT_FLAGS} --rcfile=${TOP}/.pylintrc ${PYTHON}

lint: pylint

yapf:
	${YAPF} ${YAPF_FLAGS} -d ${PYTHON}

docs:
	make -C docs html

test:
	echo 0 # Placeholder for the test command

upload:
	python setup.py sdist && python setup.py bdist_wheel && twine upload dist/*
