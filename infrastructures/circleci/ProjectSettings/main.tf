provider "circleci" {
    api_token    = var.circleci_token
    vcs_type     = "github"
    organization = var.circleci_organization
}

resource "circleci_environment_variable" "aws_access_key" {
    project = var.circleci_project_name
    name    = "AWS_ACCESS_KEY_ID"
    value   = var.aws_access_key
}

resource "circleci_environment_variable" "aws_secret_key" {
    project = var.circleci_project_name
    name    = "AWS_SECRET_ACCESS_KEY"
    value   = var.aws_secret_key
}

resource "circleci_environment_variable" "aws_region" {
    project = var.circleci_project_name
    name    = "AWS_DEFAULT_REGION"
    value   = var.aws_region
}

resource "circleci_environment_variable" "aws_account_id" {
    project = var.circleci_project_name
    name    = "AWS_ACCOUNT_ID"
    value   = var.aws_account_id
}

resource "circleci_environment_variable" "docker_login" {
    project = var.circleci_project_name
    name    = "DOCKER_LOGIN"
    value   = var.docker_login
}

resource "circleci_environment_variable" "docker_pwd" {
    project = var.circleci_project_name
    name    = "DOCKER_PWD"
    value   = var.docker_pwd
}
