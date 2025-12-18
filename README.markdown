# skv

simple key value store.

a minimal key value store for bash scripting

## Usage

    $ skv my-scheme put mykey foobar
	$ skv my-scheme get mykey
	foobar
	$ skv scheme-ls
	my-scheme

## Installation

1. install sbcl and ocicl
2. run `make build`
3. mv `skv` to your $PATH
4. load `skv-completions.bash`
