PROJECT_NAME=Diagmet-I-02
include ../basic.make

# Uncomment the following line to force Make to use a specific shell
# SHELL := /bin/bash
MAKEFLAGS += --no-builtin-rules
ifneq (,$(shell which latexmk 2> /dev/null))
	LATEX := latexmk --pdf
else
	LATEX := pdflatex
endif

.PHONY: all
all: protokol.pdf

#epsfigs = $(patsubst %,unknown-%,1 2 3 4)
epsfigs = residual argon ionization-1 ionization-2 plasma unknown-all
figs = ${epsfigs:%=plots/%.tex} ${epsfigs:%=plots/%.eps}
tex_resources = build/plots ${figs}

build/plots:
	mkdir -p build/plots

plots:
	mkdir -p plots

plots/unknown-%: identification.m identification_export.m plots
	octave --norc identification_export.m

plots/residual%: residual.m residual_export.m plots
	octave --norc residual_export.m

plots/argon%: argon.m argon_export.m plots
	octave --norc argon_export.m

plots/ionization%: ionization.m ionization_export.m plots
	octave --norc ionization_export.m

plots/plasma.%: plasma.m plasma_export.m plots
	octave --norc plasma_export.m

$(patsubst %,plots/cyclopropylamine-nist.%,tex eps): nist_export.m plots
	octave --norc nist_export.m

.PHONY: tex_resources
tex_resources: makefile ${tex_resources}
	@echo Successfully updated prerequisities for protokol.tex

protokol.pdf : protokol.tex ${tex_resources}
	TEXINPUTS=.:..: ${LATEX} protokol.tex && touch protokol.pdf

.PHONY: clean
clean:
	rm -rf plots
	rm -rf build
