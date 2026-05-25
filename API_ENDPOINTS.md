# Documentação de API - FMS

## Base URL
```
http://localhost:3000
```

---

## Autenticação

### 1. Login de Usuário

**Endpoint**: `POST /usuarios/autenticar`

**Descrição**: Autentica um usuário com email e senha

**Headers**:
```json
{
  "Content-Type": "application/json"
}
```

**Request Body**:
```json
{
  "emailServer": "usuario@example.com",
  "senhaServer": "Senha123"
}
```

**Response (200 OK)**:
```json
{
  "id": 1,
  "email": "usuario@example.com",
  "nome": "João Silva",
  "cargo": "Administrador",
  "restaurante": {
    "id": 1,
    "razao_social": "Restaurante João Ltda",
    "nome_fantasia": "João's Pizza",
    "cnpj": "12345678901234",
    "status": "Pendente",
    "quantmesa": 20
  }
}
```

**Response (403 Forbidden)**:
```
Email e/ou senha inválido(s)
```

**Response (400 Bad Request)**:
```
Seu email está undefined!
Sua senha está indefinida!
```

**Exemplo com cURL**:
```bash
curl -X POST http://localhost:3000/usuarios/autenticar \
  -H "Content-Type: application/json" \
  -d '{
    "emailServer": "joao@example.com",
    "senhaServer": "Senha123"
  }'
```

**Exemplo com JavaScript**:
```javascript
fetch('/usuarios/autenticar', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    emailServer: 'joao@example.com',
    senhaServer: 'Senha123'
  })
})
.then(response => response.json())
.then(data => console.log(data))
.catch(error => console.error('Erro:', error));
```

---

## Cadastro

### 2. Cadastrar Novo Usuário e Restaurante

**Endpoint**: `POST /usuarios/cadastrar`

**Descrição**: Cria um novo restaurante e usuário associado

**Headers**:
```json
{
  "Content-Type": "application/json"
}
```

**Request Body**:
```json
{
  "nomeUsuarioServer": "João Silva",
  "emailServer": "joao@example.com",
  "senhaServer": "Senha123",
  "cargoServer": "Administrador",
  "razaoSocialServer": "Restaurante João Ltda",
  "nomeFantasiaServer": "João's Pizza",
  "cnpjServer": "12345678901234",
  "quantMesasServer": 20
}
```

**Response (200 OK)**:
```json
{
  "mensagem": "Cadastro realizado com sucesso!",
  "usuario": {
    "email": "joao@example.com",
    "nome": "João Silva",
    "cargo": "Administrador"
  },
  "restaurante": {
    "razao_social": "Restaurante João Ltda",
    "nome_fantasia": "João's Pizza",
    "cnpj": "12345678901234"
  }
}
```

**Response (409 Conflict)**:
```
Email já cadastrado no sistema!
CNPJ já cadastrado no sistema!
```

**Response (400 Bad Request)**:
```
Nome do usuário está undefined!
Email está undefined!
Senha está undefined!
Razão social está undefined!
Nome fantasia está undefined!
CNPJ está undefined!
Quantidade de mesas está undefined!
```

**Response (500 Internal Server Error)**:
```json
{
  "erro": "Erro ao cadastrar restaurante",
  "detalhes": "Mensagem de erro do SQL"
}
```

**Validações Obrigatórias**:
- Email deve ser válido (conter @ e .com ou .com.br)
- Senha deve ter:
  - Mínimo 6 caracteres
  - Pelo menos 1 número
  - Pelo menos 1 letra maiúscula
  - Pelo menos 1 letra minúscula
- CNPJ deve ter exatamente 14 dígitos
- Quantidade de mesas deve ser > 0
- Email não pode estar duplicado
- CNPJ não pode estar duplicado

**Exemplo com cURL**:
```bash
curl -X POST http://localhost:3000/usuarios/cadastrar \
  -H "Content-Type: application/json" \
  -d '{
    "nomeUsuarioServer": "João Silva",
    "emailServer": "joao@example.com",
    "senhaServer": "Senha123",
    "cargoServer": "Administrador",
    "razaoSocialServer": "Restaurante João Ltda",
    "nomeFantasiaServer": "João'\''s Pizza",
    "cnpjServer": "12345678901234",
    "quantMesasServer": 20
  }'
```

**Exemplo com JavaScript**:
```javascript
fetch('/usuarios/cadastrar', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    nomeUsuarioServer: 'João Silva',
    emailServer: 'joao@example.com',
    senhaServer: 'Senha123',
    cargoServer: 'Administrador',
    razaoSocialServer: 'Restaurante João Ltda',
    nomeFantasiaServer: 'João\'s Pizza',
    cnpjServer: '12345678901234',
    quantMesasServer: 20
  })
})
.then(response => response.json())
.then(data => console.log(data))
.catch(error => console.error('Erro:', error));
```

---

## Usuários

### 3. Buscar Usuário por Email

**Endpoint**: `GET /usuarios/buscar-email/:email`

**Descrição**: Busca um usuário pelo email

**Path Parameters**:
- `email` (string): Email do usuário

**Response (200 OK)**:
```json
[
  {
    "id": 1,
    "nome": "João Silva",
    "email": "joao@example.com",
    "cargo": "Administrador",
    "restauranteId": 1
  }
]
```

**Response (404 Not Found)**:
```json
[]
```

---

### 4. Buscar Usuário por ID

**Endpoint**: `GET /usuarios/buscar-id/:id`

**Descrição**: Busca um usuário pelo ID

**Path Parameters**:
- `id` (number): ID do usuário

**Response (200 OK)**:
```json
[
  {
    "id": 1,
    "nome": "João Silva",
    "email": "joao@example.com",
    "cargo": "Administrador",
    "restauranteId": 1
  }
]
```

**Response (404 Not Found)**:
```json
[]
```

---

## Restaurantes

### 5. Buscar Restaurante por CNPJ

**Endpoint**: `GET /restaurantes/buscar-cnpj/:cnpj`

**Descrição**: Busca um restaurante pelo CNPJ

**Path Parameters**:
- `cnpj` (string): CNPJ do restaurante (14 dígitos)

**Response (200 OK)**:
```json
[
  {
    "id": 1,
    "razao_social": "Restaurante João Ltda",
    "nome_fantasia": "João's Pizza",
    "cnpj": "12345678901234",
    "status": "Pendente",
    "quantmesa": 20
  }
]
```

**Response (404 Not Found)**:
```json
[]
```

---

### 6. Buscar Restaurante por ID

**Endpoint**: `GET /restaurantes/buscar-id/:id`

**Descrição**: Busca um restaurante pelo ID

**Path Parameters**:
- `id` (number): ID do restaurante

**Response (200 OK)**:
```json
[
  {
    "id": 1,
    "razao_social": "Restaurante João Ltda",
    "nome_fantasia": "João's Pizza",
    "cnpj": "12345678901234",
    "status": "Pendente",
    "quantmesa": 20
  }
]
```

**Response (404 Not Found)**:
```json
[]
```

---

### 7. Listar Todos os Restaurantes

**Endpoint**: `GET /restaurantes/listar`

**Descrição**: Lista todos os restaurantes cadastrados

**Response (200 OK)**:
```json
[
  {
    "id": 1,
    "razao_social": "Restaurante João Ltda",
    "nome_fantasia": "João's Pizza",
    "cnpj": "12345678901234",
    "status": "Pendente",
    "quantmesa": 20
  },
  {
    "id": 2,
    "razao_social": "Pizzaria Di Napoli Alimentos Ltda",
    "nome_fantasia": "Bella Napoli",
    "cnpj": "11222333000111",
    "status": "Aprovado",
    "quantmesa": 40
  }
]
```

---

## Códigos de Status HTTP

| Código | Descrição |
|--------|-----------|
| 200 | OK - Requisição bem-sucedida |
| 400 | Bad Request - Dados inválidos ou incompletos |
| 403 | Forbidden - Email/senha inválido |
| 404 | Not Found - Recurso não encontrado |
| 409 | Conflict - Email ou CNPJ duplicado |
| 500 | Internal Server Error - Erro no servidor |

---

## Fluxo Recomendado

### Cadastro
1. **POST** `/usuarios/cadastrar` com dados do usuário e restaurante
2. Validar resposta (200 = sucesso, 409 = duplicado, 400 = inválido)
3. Redirecionar para login

### Login
1. **POST** `/usuarios/autenticar` com email e senha
2. Validar resposta (200 = sucesso, 403 = inválido)
3. Armazenar dados em `sessionStorage`
4. Redirecionar para dashboard

---

## Autenticação e Segurança

### Senhas
- Senhas são armazenadas com hash bcrypt (10 rounds)
- Senhas antigas em texto plano ainda funcionam para compatibilidade
- Novas senhas são automaticamente hasheadas

### SessionStorage
Após login bem-sucedido, os seguintes dados são armazenados:
- `ID_USUARIO`: ID do usuário
- `EMAIL_USUARIO`: Email do usuário
- `NOME_USUARIO`: Nome do usuário
- `CARGO_USUARIO`: Cargo (Administrador/Operador)
- `RESTAURANTE_ID`: ID do restaurante
- `RESTAURANTE_NOME`: Nome fantasia do restaurante

---

## Tratamento de Erros

### Exemplo de Tratamento Completo

```javascript
async function login(email, senha) {
  try {
    const response = await fetch('/usuarios/autenticar', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        emailServer: email,
        senhaServer: senha
      })
    });

    if (response.ok) {
      const data = await response.json();
      // Armazenar dados
      sessionStorage.setItem('ID_USUARIO', data.id);
      sessionStorage.setItem('EMAIL_USUARIO', data.email);
      // ... outros dados
      return { sucesso: true, dados: data };
    } else if (response.status === 403) {
      return { sucesso: false, erro: 'Email e/ou senha inválido(s)' };
    } else if (response.status === 400) {
      const erro = await response.text();
      return { sucesso: false, erro: erro };
    } else {
      return { sucesso: false, erro: 'Erro no servidor' };
    }
  } catch (error) {
    return { sucesso: false, erro: error.message };
  }
}
```

---

## Postman Collection

Você pode importar esta collection no Postman para testar os endpoints:

```json
{
  "info": {
    "name": "FMS API",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Login",
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "Content-Type",
            "value": "application/json"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\"emailServer\": \"joao@example.com\", \"senhaServer\": \"Senha123\"}"
        },
        "url": {
          "raw": "http://localhost:3000/usuarios/autenticar",
          "protocol": "http",
          "host": ["localhost"],
          "port": "3000",
          "path": ["usuarios", "autenticar"]
        }
      }
    },
    {
      "name": "Cadastro",
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "Content-Type",
            "value": "application/json"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\"nomeUsuarioServer\": \"João Silva\", \"emailServer\": \"joao@example.com\", \"senhaServer\": \"Senha123\", \"cargoServer\": \"Administrador\", \"razaoSocialServer\": \"Restaurante João Ltda\", \"nomeFantasiaServer\": \"João's Pizza\", \"cnpjServer\": \"12345678901234\", \"quantMesasServer\": 20}"
        },
        "url": {
          "raw": "http://localhost:3000/usuarios/cadastrar",
          "protocol": "http",
          "host": ["localhost"],
          "port": "3000",
          "path": ["usuarios", "cadastrar"]
        }
      }
    }
  ]
}
```

---

**Data**: 25 de maio de 2026  
**Versão**: 1.0  
**Última atualização**: 25 de maio de 2026
