# refs
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy
# https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html

resource "aws_ecr_repository" "auth-client_nginx-proxy" {
    name = "auth-client/nginx-proxy"

    # タグのイミュータビリティ
    image_tag_mutability = "MUTABLE"

    # プッシュ時にスキャン
    image_scanning_configuration {
        scan_on_push = false
    }

    # 暗号化タイプ
    encryption_configuration {
        encryption_type = "AES256"
    }
}

resource "aws_ecr_lifecycle_policy" "auth-client_nginx-proxy_policy" {
    repository = aws_ecr_repository.auth-client_nginx-proxy.name

    policy = jsonencode(
    {
        rules = [
            {
                action = {
                    type = "expire"
                }
                description = "Hold only one untagged image"
                rulePriority = 1
                selection = {
                    tagStatus = "untagged"
                    countType = "imageCountMoreThan"
                    countNumber = 1
                }
            },
        ]
    }
    )
}


resource "aws_ecr_repository" "auth-client_laravel-app" {
    name = "auth-client/laravel-app"

    # タグのイミュータビリティ
    image_tag_mutability = "MUTABLE"

    # プッシュ時にスキャン
    image_scanning_configuration {
        scan_on_push = false
    }

    # 暗号化タイプ
    encryption_configuration {
        encryption_type = "AES256"
    }
}

resource "aws_ecr_lifecycle_policy" "auth-client_laravel-app_policy" {
    repository = aws_ecr_repository.auth-client_laravel-app.name

    policy = jsonencode(
    {
        rules = [
            {
                action = {
                    type = "expire"
                }
                description = "Hold only one untagged image"
                rulePriority = 1
                selection = {
                    tagStatus = "untagged"
                    countType = "imageCountMoreThan"
                    countNumber = 1
                }
            },
        ]
    }
    )
}
