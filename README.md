Infraestrutura para Grafana e Loki com AWS ECS, DynamoDB e S3
Este projeto utiliza Terraform para provisionar a infraestrutura na AWS, configurando serviços como ECS Fargate, Grafana, Loki, DynamoDB e S3. Ele está preparado para rodar o Grafana com persistência no DynamoDB e o Loki configurado para armazenar logs no S3.

Tecnologias Utilizadas
AWS ECS Fargate: Orquestração de containers para Grafana e Loki.

Terraform: Provisionamento e gerenciamento da infraestrutura.

Grafana: Monitoramento e visualização de dados com Loki como fonte de logs.

Loki: Coleta e indexação de logs.

DynamoDB: Banco de dados serverless para persistir as configurações do Grafana.

S3: Armazenamento dos logs coletados pelo Loki.

Secrets Manager: Armazenamento seguro das credenciais de admin do Grafana.

Arquitetura
A arquitetura consiste em:

VPC com subnets públicas para acesso aos serviços.

ECS Fargate Cluster rodando containers para o Grafana e Loki.

Application Load Balancer (ALB) expõe o Grafana e realiza o roteamento.

DynamoDB para persistência das configurações do Grafana (como dashboards e usuários).

S3 para armazenamento dos logs coletados pelo Loki.

IAM Roles para garantir permissões seguras entre os serviços (ECS, S3, DynamoDB, etc).

Pré-requisitos
Terraform instalado na sua máquina.

Conta AWS configurada com as permissões necessárias para criar os recursos.

Passos para Subir a Infraestrutura:

1. Clone o Repositório
git clone <url-do-repositorio>
cd <nome-do-repositorio>

2. Configuração do Terraform
2.1 Iniciar o Terraform
terraform init

2.2 Verificar o Plano de Execução
terraform plan

2.3 Aplicar a Infraestrutura
terraform apply -auto-approve

Isso criará todos os recursos necessários no AWS, como a VPC, ECS, ALB, DynamoDB, S3, e configurará o Grafana e Loki.

Acessando o Grafana
Após a criação da infraestrutura, o Terraform irá gerar a URL do Load Balancer. Acesse o Grafana pelo seguinte link:

http://<load-balancer-dns>:9091

O usuário e a senha do Grafana são armazenados de forma segura no AWS Secrets Manager. O Grafana acessará esses segredos automaticamente.

Persistência de Logs com Loki
O Loki coleta logs e os envia para o S3. Para verificar o status do Loki, você pode acessar a URL do Load Balancer na porta 9092.

Componentes do Projeto
1. VPC e Subnets
Criação de uma VPC com subnets públicas para expor os serviços.

2. ECS Fargate Cluster
Ambiente gerenciado para rodar as tasks do Grafana e Loki.

3. Application Load Balancer
Responsável por direcionar o tráfego para os containers Grafana e Loki.

4. DynamoDB
Armazena as configurações do Grafana (ex: usuários, dashboards).

5. S3
Armazena os logs coletados pelo Loki.

6. Secrets Manager
Armazena de forma segura as credenciais do Grafana.

7. IAM Roles
Permite o acesso aos recursos necessários com segurança.

Configuração de Segurança
IAM Roles: As permissões mínimas necessárias são configuradas para que o ECS possa acessar o Secrets Manager e o S3 de maneira segura.

Security Groups: As portas foram configuradas para 9091 (Grafana) e 9092 (Loki), além de restringir o tráfego conforme necessário.

Licença
Este projeto está licenciado sob a MIT License - veja o arquivo LICENSE para mais detalhes.
