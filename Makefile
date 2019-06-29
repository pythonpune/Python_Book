IMAGE = digitronik/latex:latest
BOOK = main_book.tex

help:
	@echo pull: Pull LaTeX docker image.
	@echo build: Build/Run project.
	@echo clean: Clean aux, log, out, tox files
	@echo cleanall: Clean all files created by LaTeX
	@echo indent: Indentation for LaTeX
	@echo checks: Check LaTeX syntax with lacheck and chtex

.DEFAULT_GOAL := help

pull:
	@echo "Pulling LaTeX docker image..."
	docker pull ${IMAGE}
build:
	@echo "Building project..."
	@exec docker run --rm -i -v ${PWD}:/data ${IMAGE} pdflatex ${BOOK}
	@echo "Successfully build"
clean:
	@echo "Cleaning *.aux *.log *.out *.toc *.bak"
	@rm -rf *.aux *.log *.out *.toc *.bak*
	@echo "Successfully clean aux, log, tox, out file."
cleanall:
	@echo "Cleaning all files created by LaTeX..."
	@rm -rf *.aux *.log *.out *.toc *.pdf *.bak*
	@echo "Successfully clean all files created by LaTeX."
indent:
	@echo "make indentation for tex file"
	@rm -rf *.bak*
	@exec docker run --rm -i -v ${PWD}:/data ${IMAGE} latexindent -s --overwrite ${BOOK}
	@exec cmp ${BOOK} *.bak*
checks:
	@echo "--------------------- chktex --------------------"
	@exec docker run --rm -i -v ${PWD}:/data ${IMAGE} chktex ${BOOK}
