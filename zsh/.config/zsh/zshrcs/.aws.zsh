# AWS
alias awswhoami="aws sts get-caller-identity"

# command for switching AWS profiles
alias awsps='export AWS_PROFILE=$(awssoh li | fzf)'

export AWS_SDK_LOAD_CONFIG=1
