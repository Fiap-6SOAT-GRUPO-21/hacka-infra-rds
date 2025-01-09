# RDS

## Descrição

Esse repositório contém os códigos Terraform para deployment da infraestrutura na AWS utilizada na fase do hackaton, bem como provionamento de pods kubernetes da aplicação.

Todo provisionamento foi feito asssumindo-se que AWS Academy está sendo utilizado.  AWS Academy não permite a criação de IAM roles ou qualquer outro recurso relacioado a AWS IAM. Sendo assim, em todos os módulos é utilizado o role LabRole pre-existente na AWS Academy.

As seguintes tarefas são realizadas por esse código Terradorm:

* Através do módulo rds: Provisionamento da instância de database RDS postgres que será usado pela aplicação, apontando para a subnet prublica para permitir acesso externo (Apenas para fins de teste)

## Este repositório NÃO contém pipeline de destroy, pipe de destroy está no repositório de infraestrutura.

## Fazendo Deployment via ACTION

O action 'terraform apply' pode ser usado para realizar o deployment do RDS.

1. Execute o outro action que fornece a infraestrutura necessária para o RDS
2. Execute o seguinte comando para configurar as credenciais do cluster EKS na sua máquina e poder executar comandos com kubectl
```bash
aws eks --region us-east-1 update-kubeconfig --name hacka
```
### Lembre-se de executar a pipe 'terraform destroy' ao final dos testes

## Testando na máquina local aponta para o ambiente AWS Academy

1. Inicialize o laboratório no AWS Academy
2. Copie as credenciais disponíveis em AWS Details (ver AWS CLI em CLoud Access) para o arquivo ~/.aws/credentials da sua máquina
3. Comente o blco  do s3 backend no arquivo provider.tf
5. Execute 'terraform init':
```bash
terraform init
```
6. Execute 'terraform apply' para subir a infraestrutura:
```bash
  terraform apply
```
7. Execute o seguinte comando de deploy da aplicação:
```bash
  terraform destroy
```

### Lembre-se de executar 'terraform destroy' ao final dos testes

## Obtendo ip do banco de dados RDS

1. No AWS Academy va em  "RDS"
2. Clique em "Databases"
3. Clique no banco de dados criado
4. Copie o endpoint do banco de dados
5. Acesse o banco através de qualquer ferramenta de acesso a banco de dados

ou via comando aws cli, mas antes rode o comando do passo 6 do tópico anterior:
```bash
aws rds describe-db-instances --query "DBInstances[*].Endpoint.Address" --output text
```