pipeline {
    agent any

    environment {
        // Define las variables de entorno para las credenciales de AWS
        AWS_KEY_SSH = credentials('clave')
    }

    parameters {
        string(name: 'TERRAFORM_MODULE', defaultValue: '.', description: 'Inserte la ruta del módulo de terraform.')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Aprobar automáticamente.')
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Seleccione la acción a realizar.')
    }

    stages {
        stage("Configurando terraform") {
            steps {
                script {
                    echo '########## Configurando terraform... ##########'
                    sh 'terraform --version'
                    sh "ls -lt ${params.TERRAFORM_MODULE}"
                }
            }
        }

        stage("Iniciando Modulo de terraform") {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'awscredenciales', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        echo '########## Iniciando Terraform... ##########'
                        sh "terraform init ${params.TERRAFORM_MODULE}"
                    }
                }
            }
        }

        stage("Generando terraform plan") {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'awscredenciales', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        echo '########## Iniciando Terraform Plan... ##########'
                        sh "terraform plan -out=tfplan ${params.TERRAFORM_MODULE}"
                    }
                }
            }
        }

        stage("Generando terraform Apply / Destroy") {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'awscredenciales', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        echo '########## Iniciando Terraform Apply / Destroy ... ##########'
                        if (params.action == 'apply') {
                            if (!params.autoApprove) {
                                input(message:'Deseas desplegar el módulo de terraform', ok: 'Apply')
                            }
                            sh "terraform apply -auto-approve ${params.TERRAFORM_MODULE}"
                        } else if (params.action == 'destroy') {
                            if (!params.autoApprove) {
                                input(message:'Desea eliminar el módulo de terraform', ok: 'Destroy')
                            }
                            sh "terraform destroy -auto-approve ${params.TERRAFORM_MODULE}"
                        } else {
                            error "Acción inválida, elige una opción válida"
                        }
                    }
                }
            }
        }
    }
}
