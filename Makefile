ROOT_DIR := `git rev-parse --show-toplevel`
SCRIPTS_DIR := ${ROOT_DIR}/scripts

unstow:
	@${SCRIPTS_DIR}/stowdf \
		-D ${TO_STOW}
stow:
	@${SCRIPTS_DIR}/stowdf \
		${TO_STOW}

bootstrap: 
	echo "TODO"
