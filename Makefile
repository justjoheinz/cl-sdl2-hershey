
LISP=ros run --

.PHONY: help all clean example

help: ## show help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

all: ## Compile all artifacts and execute tests
	$(LISP) \
		--disable-debugger \
		--eval '(ql:quickload :cl-sdl2-hershey)' \
		--eval '(ql:quickload :cl-sdl2-hershey/example)' \
		--eval '(ql:quickload :cl-sdl2-hershey/tests)' \
		--eval '(uiop:quit (if (rove:run "cl-sdl2-hershey/tests") 0 1))'

clean: ## Recursively delete fasl file
	find ./ -name "*.fasl" -delete

example: ## Run the example
	$(LISP) \
		--non-interactive \
		--eval '(ql:quickload :cl-sdl2-hershey/example)' \
		--eval "(sdl2:make-this-thread-main #'cl-sdl2-hershey/example:main)"

