

_skv() {
    case "$3" in
	scheme-ls|get|put|rm|ls) COMPREPLY=( $(compgen -W $(skv scheme-ls) -- "$2") ) ;;
	skv) COMPREPLY=( $(compgen -W "help get put rm ls scheme-ls scheme-rm" -- "$2") ) ;;
    esac
}
complete -F _skv skv
