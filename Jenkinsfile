pipeline{
    agent any

    environment {
        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awscredenciales', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')])
    }
    parameters {
        string(name: 'TERRAFORM_MODULE', description: 'Inserte la ruta del módulo de terraform.')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Aprobar automáticamente.')
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Seleccione la acción a realizar.')
    }
    stages{
        stage ("Configurando terraform "){
            script {
                    print '########## Configurando Credenciales... ##########'
                    sh 'terraform --version'
                    sh 'ls -lt $WORKSPACE/$TERRAFORM_MODULE'
                    sh 'ls -lt'             
            }
        }
        stage ("Iniciando Modulo de terraform "){
            steps {
                script {
                    print '########## Configurando Credenciales... ##########'
                    // Configura las credenciales de AWS para Terraform
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'awscredenciales', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) 
                    sh 'terraform -chdir=$WORKSPACE/$TERRAFORM_MODULE init'  
                }
            }
            
        }
        stage ("Generando terraform plan "){
            steps{
                script {
                    print '########## Iniciando Terraform Plan... ##########'
                    sh 'terraform -chdir=$WORKSPACE/$TERRAFORM_MODULE plan -out=tfplan'         
                }
            }
          
        }
        stage ("Generando terraform Apply / Destroy "){
            steps{
                script {
                    print '########## Iniciando Terraform Apply / Destroy ... ##########'
                        if (params.action == 'apply') {
                            if(!param.approve){
                               input(message:'Deseas desplegar el módulo de terraform', ok: 'Apply') 
                            }
                            sh 'terraform -chdir=$WORKSPACE/$TERRAFORM_MODULE apply -auto-approve'         
                        }
                        else if ( params.action == 'destroy'){
                            if(!params.aprove){
                                input(message:'Desea eliminar el módulo de terraform', ok: 'Destroy')
                            }
                            sh 'terraform -chdir=$WORKSPACE/$TERRAFORM_MODULE apply -auto-approve' 
                        }
                        else {
                            error: "Acción inválida elige una opción"
                        }
                }
            }
        }
    }