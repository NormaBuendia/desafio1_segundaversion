pipeline{
    agent any

    environment {
        // Define las variables de entorno para las credenciales de AWS
        AWS_KEY_SSH = credentials('clave')

    }
    parameters {
        string(name: 'TERRAFORM_MODULE', description: 'Inserte la ruta del módulo de terraform.')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Aprobar automáticamente.')
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Seleccione la acción a realizar.')
    }
    stages{
        stage ("Configurando terraform "){
            steps{
                script {
                    print '########## Configurando Credenciales... ##########'
                    sh 'terraform --version'
                    //sh 'ls -lt $WORKSPACE/$TERRAFORM_MODULE'
                    sh "ls -lt ${WORKSPACE}/${TERRAFORM_MODULE}"
                    sh 'ls -lt'             
                }
            }
        }
        stage ("Iniciando Modulo de terraform "){
            steps {
                script {
                    print '########## Iniciando Terraform... ##########'  
                    //sh 'terraform -chdir=$WORKSPACE/$TERRAFORM_MODULE init'  
                    sh 'terraform -chdir=${WORKSPACE}/${TERRAFORM_MODULE} init'  
                }
            }
            
        }
        stage ("Generando terraform plan "){
            steps{
                script {
                    print '########## Iniciando Terraform Plan... ##########'
                    //sh 'terraform -chdir=$WORKSPACE/$TERRAFORM_MODULE plan -out=tfplan' 
                    sh 'terraform -chdir=${WORKSPACE}/${TERRAFORM_MODULE} plan -out=tfplan'        
                }
            }
          
        }
        stage ("Generando terraform Apply / Destroy "){
            steps{
                script {
                    print '########## Iniciando Terraform Apply / Destroy ... ##########'
                        if (params.action == 'apply') {
                            if(!params.approve){
                               input(message:'Deseas desplegar el módulo de terraform', ok: 'Apply') 
                            }
                            //sh 'terraform -chdir=$WORKSPACE/$TERRAFORM_MODULE apply -auto-approve terraform/' 
                            sh 'terraform -chdir=${WORKSPACE}/${TERRAFORM_MODULE} apply -auto-approve terraform/'         
                        }
                        else if ( params.action == 'destroy'){
                            if(!params.aprove){
                                input(message:'Desea eliminar el módulo de terraform', ok: 'Destroy')
                            }
                            //sh 'terraform -chdir=$WORKSPACE/$TERRAFORM_MODULE apply -auto-approve terraform/'
                            sh 'terraform -chdir=${WORKSPACE}/${TERRAFORM_MODULE} apply -auto-approve terraform/'  
                        }
                        else {
                            error: "Acción inválida elige una opción"
                        }
                }
            }
        }
    }
}