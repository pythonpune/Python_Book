IMAGE = digitronik/latex:latest
BOOK = main_book

help:
	@echo pull: Pull LaTeX docker image.
	@echo build: Build/Run project.
	@echo clean: Clean aux, log, out, tox files
	@echo cleanall: Clean all files created by LaTeX

.DEFAULT_GOAL := help

pull:
	@echo "Pulling LaTeX docker image..."
	docker pull ${IMAGE}
build:
	@echo "Building project..."
	@exec docker run --rm -i -v ${PWD}:/data ${IMAGE} pdflatex ${BOOK}.tex
	@echo "Successfully build"
clean:
	@echo "Cleaning *.aux *.log *.out *.toc"
	@rm -rf *.aux *.log *.out *.toc
	@echo "Successfully clean aux, log, tox, out file."
cleanall:
	@echo "Cleaning all files created by LaTeX..."
	@rm -rf *.aux *.log *.out *.toc *.pdf
	@echo "Successfully clean all files created by LaTeX."
