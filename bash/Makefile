init: clean
	export PYTHONPATH=""; /sw/int/eclear/software/python-3.6.7/bin/python3.6 -m venv env --prompt="My Project"; \
	source env/bin/activate; pip install --upgrade pip; pip install -r requirements.txt; pip install -e .
	$(MAKE) cil

dev-init: clean
ifndef MP_HOME
	$(error MP_HOME should be set to the C7_FW repository.)
else
	export PYTHONPATH=""; /sw/int/eclear/software/python-3.6.7/bin/python3.6 -m venv env --prompt="My Project"; \
	source env/bin/activate; pip install --upgrade pip; pip install -r $(MP_HOME)/requirements.txt; \
	python -m pip install -e $(MP_HOME); pip install -e $(MP_HOME) --no-deps; pip install -e .
	$(MAKE) cil
endif

clean:
	@rm -rf ./env

PATH := $(PWD):$(PATH)
