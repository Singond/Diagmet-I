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
epsfigs = residual argon ionization-1 ionization-2 plasma
epsfigs += plasma-ar plasma-arh plasma-nn unknown-all
epsfigs += cyclopropylamine-nist
figs = ${epsfigs:%=plots/%.tex} ${epsfigs:%=plots/%.eps}
tex_resources = build/plots ${figs}

build/plots:
	mkdir -p build/plots

plots:
	mkdir -p plots

plots/unknown-%: identification.m identification_export.m massspec.gp plots
	octave --norc identification_export.m

results/unknown.csv: identification.m identification_export.m massspec.gp plots
	octave --norc identification_export.m

plots/residual.tex plots/residual.eps results/residual.csv: \
residual.m residual_export.m massspec.gp plots
	octave --norc residual_export.m

plots/argon.tex plots/argon.eps results/argon.csv: \
argon.m argon_export.m massspec.gp plots
	octave --norc argon_export.m

plots/ionization%: ionization.m ionization_export.m plots
	octave --norc ionization_export.m

plots/plasma.tex plots/plasma.eps results/plasma.csv: \
plasma.m plasma_export.m massspec.gp plots
	octave --norc plasma_export.m

plots/plasma-%: energy.m energy_export.m plots
	octave --norc energy_export.m

$(patsubst %,plots/cyclopropylamine-nist.%,tex eps): nist_export.m \
massspec.gp plots
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
