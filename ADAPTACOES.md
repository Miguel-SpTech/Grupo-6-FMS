# FMS - Adaptações de Autenticação e Banco de Dados

## Resumo das Alterações

Este documento descreve todas as adaptações realizadas no projeto FMS para implementar autenticação real com banco de dados, cadastro de restaurantes e usuários.

---

## 1. Alterações no Backend

### 1.1 Novo Modelo: `restauranteModel.js`
- **Arquivo**: `src/models/restauranteModel.js`
- **Funções**:
  - `buscarPorCnpj(cnpj)`: Busca restaurante por CNPJ
  - `buscarPorId(id)`: Busca restaurante por ID
  - `listar()`: Lista todos os restaurantes
  - `cadastrar(razao_social, nome_fantasia, cnpj, quantmesa)`: Cadastra novo restaurante

### 1.2 Modelo Atualizado: `usuarioModel.js`
- **Arquivo**: `src/models/usuarioModel.js`
- **Alterações**:
  - Corrigidas queries SQL para usar tabelas reais do FMS (`Usuario`, `Restaurante`)
  - Implementado suporte a hash de senha com **bcryptjs**
  - Adicionadas funções: `buscarPorEmail()`, `buscarPorId()`
  - Compatibilidade com senhas antigas em texto plano
  - Uso de Promises para operações assíncronas

### 1.3 Controlador Atualizado: `usuarioController.js`
- **Arquivo**: `src/controllers/usuarioController.js`
- **Alterações**:
  - Função `autenticar()`: Agora retorna dados do restaurante associado
  - Função `cadastrar()`: Implementa fluxo completo de cadastro
    - Valida email e CNPJ duplicados
    - Cria restaurante primeiro
    - Cria usuário vinculado ao restaurante
    - Retorna confirmação com dados de ambos

### 1.4 Dependências Adicionadas
- **bcryptjs**: Para hash seguro de senhas
- Adicionado ao `package.json`

---

## 2. Alterações no Frontend

### 2.1 Página de Login: `public/login.html`
- **Alterações**:
  - Removida lógica de `localStorage` local
  - Implementado `fetch()` para chamar API `/usuarios/autenticar`
  - Armazenamento de sessão em `sessionStorage`:
    - `ID_USUARIO`
    - `EMAIL_USUARIO`
    - `NOME_USUARIO`
    - `CARGO_USUARIO`
    - `RESTAURANTE_ID`
    - `RESTAURANTE_NOME`
  - Suporte a login com tecla Enter
  - Feedback visual de carregamento

### 2.2 Página de Cadastro: `public/cadastro.html`
- **Alterações**:
  - Completamente reescrita com nova estrutura
  - Separação clara entre dados do usuário e restaurante
  - Validações robustas:
    - Email válido
    - Senha com requisitos (6+ caracteres, número, maiúscula, minúscula)
    - CNPJ com 14 dígitos
    - Quantidade de mesas > 0
  - Implementado `fetch()` para chamar API `/usuarios/cadastrar`
  - Tratamento de erros com mensagens claras
  - Redirecionamento automático para login após sucesso

---

## 3. Mapeamento de Tabelas do Banco

### Tabela: `Usuario`
```sql
idUsuario INT PRIMARY KEY
nome VARCHAR(100)
email VARCHAR(100)
senha VARCHAR(255) -- Hash bcrypt
cargo VARCHAR(13) -- 'Administrador' ou 'Operador'
fkRestaurante INT -- FK para Restaurante
```

### Tabela: `Restaurante`
```sql
idRestaurante INT PRIMARY KEY
razao_social VARCHAR(100)
nome_fantasia VARCHAR(100)
cnpj CHAR(14)
status VARCHAR(9) -- 'Pendente' ou 'Aprovado'
quantmesa INT
```

---

## 4. Fluxo de Autenticação

### Cadastro
1. Usuário preenche dados de usuário e restaurante
2. Frontend valida todos os campos
3. Frontend envia POST para `/usuarios/cadastrar`
4. Backend verifica duplicidade de email e CNPJ
5. Backend cria restaurante com status 'Pendente'
6. Backend cria usuário vinculado ao restaurante
7. Usuário é redirecionado para login

### Login
1. Usuário insere email e senha
2. Frontend envia POST para `/usuarios/autenticar`
3. Backend busca usuário por email
4. Backend compara senha (hash bcrypt ou texto plano)
5. Backend retorna dados do usuário e restaurante
6. Frontend armazena em `sessionStorage`
7. Usuário é redirecionado para dashboard

---

## 5. Instalação e Configuração

### Pré-requisitos
- Node.js 14+
- MySQL 5.7+
- Arquivo `.env` com variáveis de ambiente

### Variáveis de Ambiente (.env)
```
DB_HOST=localhost
DB_DATABASE=FMS
DB_USER=root
DB_PASSWORD=sua_senha
DB_PORT=3306
AMBIENTE_PROCESSO=desenvolvimento
HOST_APP=localhost
PORTA_APP=3000
```

### Instalação
```bash
# Instalar dependências
npm install

# Iniciar servidor em desenvolvimento
npm run dev

# Ou iniciar em produção
npm start
```

---

## 6. Endpoints da API

### Autenticação
- **POST** `/usuarios/autenticar`
  - Body: `{ emailServer, senhaServer }`
  - Response: `{ id, email, nome, cargo, restaurante }`

### Cadastro
- **POST** `/usuarios/cadastrar`
  - Body: `{ nomeUsuarioServer, emailServer, senhaServer, cargoServer, razaoSocialServer, nomeFantasiaServer, cnpjServer, quantMesasServer }`
  - Response: `{ mensagem, usuario, restaurante }`

---

## 7. Segurança

### Implementações
- ✅ Senhas com hash bcrypt (10 rounds)
- ✅ Validação de email e CNPJ duplicados
- ✅ Validação de requisitos de senha no frontend
- ✅ Uso de `sessionStorage` (não `localStorage`) para dados sensíveis
- ✅ Tratamento de erros sem expor detalhes internos

### Recomendações Futuras
- Implementar HTTPS em produção
- Adicionar rate limiting nos endpoints de autenticação
- Implementar JWT tokens para sessões
- Adicionar validação de CNPJ com algoritmo de check digit
- Implementar verificação de email (envio de link de confirmação)
- Adicionar logs de auditoria para tentativas de login

---

## 8. Testes Recomendados

### Cadastro
- [ ] Cadastro com dados válidos
- [ ] Rejeição de email duplicado
- [ ] Rejeição de CNPJ duplicado
- [ ] Validação de senha fraca
- [ ] Validação de email inválido
- [ ] Validação de CNPJ inválido

### Login
- [ ] Login com credenciais corretas
- [ ] Rejeição de email inválido
- [ ] Rejeição de senha incorreta
- [ ] Armazenamento correto de `sessionStorage`
- [ ] Redirecionamento para dashboard

---

## 9. Estrutura de Diretórios

```
fms-adaptado/
├── src/
│   ├── controllers/
│   │   └── usuarioController.js (✅ ATUALIZADO)
│   ├── models/
│   │   ├── usuarioModel.js (✅ ATUALIZADO)
│   │   └── restauranteModel.js (✅ NOVO)
│   ├── routes/
│   │   └── usuarios.js
│   └── database/
│       └── config.js
├── public/
│   ├── login.html (✅ REESCRITO)
│   ├── cadastro.html (✅ REESCRITO)
│   └── assets/
├── package.json (✅ ATUALIZADO)
├── app.js
└── ADAPTACOES.md (✅ ESTE ARQUIVO)
```

---

## 10. Próximos Passos

Para completar a integração:

1. **Instalar dependências**: `npm install`
2. **Configurar `.env`** com credenciais do banco
3. **Executar script SQL**: `src/database/SQLFMS.sql`
4. **Testar endpoints** com Postman ou similar
5. **Validar fluxo** de cadastro e login
6. **Integrar** com páginas de dashboard existentes

---

## Notas Importantes

- As senhas antigas em texto plano ainda funcionam (compatibilidade)
- Novas senhas são automaticamente hasheadas com bcrypt
- O status do restaurante é definido como 'Pendente' no cadastro
- O cargo do usuário é definido como 'Administrador' no cadastro
- A sessão é armazenada em `sessionStorage` (limpa ao fechar a aba)

---

**Data de Adaptação**: 25 de maio de 2026  
**Versão**: 1.0
