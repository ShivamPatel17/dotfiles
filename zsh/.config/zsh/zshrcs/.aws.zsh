# AWS
alias awswhoami="aws sts get-caller-identity"

# command for switching AWS profiles
alias awsps='export AWS_PROFILE=$(dp awsso li profiles | fzf)'

export AWS_SDK_LOAD_CONFIG=1
