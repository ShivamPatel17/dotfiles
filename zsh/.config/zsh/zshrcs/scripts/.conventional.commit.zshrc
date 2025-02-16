conventional_commit () {
	# Extract ticket from the current Git branch
	get_ticket_from_branch () {
		local branch
		branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || {
			echo "Error: Not in a Git repository."
			exit 1
		}

		# Match ticket prefix and number (e.g., DPLAT-1234)
		if [[ $branch =~ ([a-zA-Z]+)-([0-9]+) ]]; then
			echo "${BASH_REMATCH[1]}-${BASH_REMATCH[2]}" | tr '[:lower:]' '[:upper:]'
		else
			echo "NOTICK"
		fi
	}

	# Prompt user to select a commit type
	select_commit_type () {
		local commit_types=("feat" "fix" "chore" "docs" "style" "refactor" "test" "perf")
		printf "%s\n" "${commit_types[@]}" | fzf --prompt="Select a commit type: "
	}

	# Get the commit type
	local commit_type
	commit_type=$(select_commit_type || true) # Prevent exit on `fzf` cancel
	if [[ -z $commit_type ]]; then
		echo "No commit type selected. Exiting."
		exit 1
	fi

	# Get optional commit scope
	local commit_scope
	echo "Enter commit scope [none]: "
	read commit_scope
	[[ -n $commit_scope ]] && commit_scope="(${commit_scope})"

	# Infer ticket from branch or use user input
	local default_ticket ticket
	default_ticket=$(get_ticket_from_branch)
	echo "Enter ticket ID [${default_ticket}]: "
	read ticket
	ticket=${ticket:-$default_ticket}

	# Get commit message
	local commit_message
	echo "Enter commit message: "
	read commit_message

	# Format and commit
	local formatted_message
	formatted_message="${commit_type}${commit_scope}: [${ticket}] ${commit_message}"
	git commit -m "$formatted_message"
}
