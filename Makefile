USER_NAME?=root
generate-ssh-key:
	ssh-keygen -t ed25519 -C "$(USER_NAME)" -f "./id_ed25519_$(USER_NAME)"
