# refs https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository

resource "aws_ecr_repository" "auth-client_proxy-nginx" {
    name = "auth-client_proxy-nginx"

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

resource "aws_ecr_repository" "auth-client_laravel-app" {
    name = "auth-client_laravel-app"

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
