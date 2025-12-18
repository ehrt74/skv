LISP ?= sbcl

build:
	$(LISP) --eval '(asdf:load-system :skv)' \
		--eval '(asdf:make :skv)' \
		--eval '(quit)'
