# Segdev - Backend Desafio 2

Uma seguradora oferece aos seus clientes pacotes personalizados para suas necessidades especificas sem que eles precisem entendem nada sobre seguros.

A seguradora determina as necessidades do cliente atravez de um formulario com informações pessoais e de risco, alem de informações sobre seus veiculos e imoveis. Usando esses dados, é determinado o perfil de risco deles para cada linha de seguros existente, sugerindo um plano de seguro ("economico", "padrao", "avancado") correspondente pro perfil de risco encontrado.

Para esse desafio, você irá criar uma versão simplificada dessa aplicação, escrevendo o recurso de uma API que recebe um payload JSON com as informações do cliente e devolve os planos sugeridos para cada linha de seguros, tambem em JSON.

## Configurando o sistema
Para configurar o sistema no seu computador você precisa do ruby configurado no seu computador.

* Ruby: 3.2.1
* Rails: 7.0.8

Siga os passos abaixo para configurar o sistema no seu computador.
1. Instale todas as dependências do Rails (gems) executando o comando: `bundle install`
2. Configure o arquivo database.yml localizado na pasta config com seu usuário e senha do banco de dados.
3. Com o banco de dados configurado, crie os bancos de dados executando:  `rails db:create`
4. Execute as migrações do banco de dados com o comando: `rails db:migrate`

# Iniciando o projeto
Agora com tudo configurado, basta executa `rails s`

## Documentação Swagger
Para acessar a documentação Swagger da API, siga os passos abaixo:
```bash
	http://localhost:3000/api-doc
```

## Acesso via API
Para acessar a API, você pode utilizar programas como o Postman, Restfox, Insomnia, entre outros.

### Calculado o Base Score:
Endpoint para Criação:
POST `/calculate`
ou
POST `/calculate-scores`


Exemplo do corpo da solicitação:
```bash
{
  "age": 35,
  "dependents": 2,
  "house": {"ownership_status": "owned"},
  "income": 0,
  "marital_status": "married",
  "risk_questions": [0, 1, 0],
  "vehicle": {"year": 2018}
}
```